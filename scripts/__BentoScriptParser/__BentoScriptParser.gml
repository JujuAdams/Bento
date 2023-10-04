//! Responsible for the syntax analysis stage of the BentoScript compiler.
//!
//! This stage creates a hierarchical representation of your BentoScript programs,
//! called an abstract syntax graph (or ASG for short). These graphs are
//! encoded as a JSON object, making it possible for you to cache the result
//! of parsing a mod to a file, instead of re-parsing each time the game loads.

//# feather use syntax-errors

/// Consumes tokens produced by a [__BentoScriptClassLexer] and transforms them into an
/// abstract syntax graph representing a BentoScript program.
///
/// @param {Struct.__BentoScriptClassLexer} lexer
///   The lexer to consume tokens from.
///
/// @param {Struct.__BentoScriptClassIRBuilder} builder
///   The syntax graph builder to write data to.
function __BentoScriptClassParser(lexer, builder) constructor {
    if (BENTOSCRIPT_DEBUG_MODE) {
        __BentoScriptCheckArgStructInstanceOf(
                "lexer", lexer, "__BentoScriptClassLexer");
        __BentoScriptCheckArgStructInstanceOf(
                "builder", builder, "__BentoScriptClassIRBuilder");
    }
    self.lexer = lexer;
    self.asg = builder;
    self.finalised = false;
    builder.pushFunction();

    /// Updates the parser by parsing a simple BentoScript expression from the
    /// supplied lexer, adding any relevant parse information to the supplied
    /// syntax graph.
    ///
    /// Returns `true` if there is still more data left to parse, and `false`
    /// if the parser has reached the end of the file.
    ///
    /// @example
    ///   Creates a new [__BentoScriptClassParser] from the variables `lexer` and
    ///   `builder`, then loops until there is nothing left to parse.
    ///
    /// ```gml
    /// var parser = new __BentoScriptClassParser(lexer, builder);
    /// var moreToParse;
    /// do {
    ///     moreToParse = parser.update();
    /// } until (!moreToParse);
    /// ```
    ///
    /// @return {Function}
    static update = function () {
        if (lexer.peek() == __BENTOSCRIPT_TOKEN.EOF) {
            if (!finalised) {
                asg.popFunction();
                finalised = true;
            }
            return false;
        }
        if (BENTOSCRIPT_DEBUG_MODE && finalised) {
            __BentoScriptError(
                "attempting to update parser after it has been finalised"
            );
        }
        __parseStatement();
        return true;
    };

    /// @ignore
    static __parseStatement = function () {
        var result;
        var peeked = lexer.peek();
        if (peeked == __BENTOSCRIPT_TOKEN.SEMICOLON) {
            lexer.next();
            return;
        } else if (peeked == __BENTOSCRIPT_TOKEN.LET) {
            lexer.next();
            if (lexer.next() != __BENTOSCRIPT_TOKEN.IDENT) {
                __ex("expected identifier after 'let' keyword");
            }
            var localName = lexer.getValue();
            var location = lexer.getLocation();
            var valueTerm;
            if (lexer.peek() == __BENTOSCRIPT_TOKEN.ASSIGN) {
                lexer.next();
                valueTerm = __parseExpression();
            } else {
                valueTerm = asg.createValue(undefined, location);
            }
            var getter = asg.allocLocal(localName, location);
            result = asg.createAssign(
                __BENTOSCRIPT_ASSIGN.VANILLA,
                getter,
                valueTerm,
                lexer.getLocation()
            );
        } else {
            result = __parseExpression();
        }
        asg.createStatement(result);
    };

    /// @ignore
    ///
    /// @return {Struct}
    static __parseExpression = function () {
        var peeked = lexer.peek();
        if (peeked == __BENTOSCRIPT_TOKEN.RETURN) {
            lexer.next();
            peeked = lexer.peek();
            var value;
            if (
                peeked == __BENTOSCRIPT_TOKEN.SEMICOLON ||
                peeked == __BENTOSCRIPT_TOKEN.BRACE_RIGHT
            ) {
                value = asg.createValue(undefined, lexer.getLocation());
            } else {
                value = __parseExpression();
            }
            return asg.createReturn(value, lexer.getLocation());
        } else if (peeked == __BENTOSCRIPT_TOKEN.CONTINUE) {
            lexer.next();
            return asg.createContinue(lexer.getLocation());
        } else if (peeked == __BENTOSCRIPT_TOKEN.BREAK) {
            lexer.next();
            peeked = lexer.peek();
            var value;
            if (
                peeked == __BENTOSCRIPT_TOKEN.SEMICOLON ||
                peeked == __BENTOSCRIPT_TOKEN.BRACE_RIGHT
            ) {
                value = asg.createValue(undefined, lexer.getLocation());
            } else {
                value = __parseExpression();
            }
            return asg.createBreak(value, lexer.getLocation());
        } else if (peeked == __BENTOSCRIPT_TOKEN.DO) {
            lexer.next();
            asg.pushBlock(true);
            __parseStatements("do");
            return asg.popBlock();
        } else if (peeked == __BENTOSCRIPT_TOKEN.IF) {
            lexer.next();
            var condition = __parseCondition();
            asg.pushBlock();
            __parseStatements("if")
            var ifTrue = asg.popBlock();
            var ifFalse;
            if (lexer.peek() == __BENTOSCRIPT_TOKEN.ELSE) {
                lexer.next();
                asg.pushBlock();
                if (lexer.peek() == __BENTOSCRIPT_TOKEN.IF) {
                    // for `else if` support
                    var elseIf = __parseExpression();
                    asg.createStatement(elseIf);
                } else {
                    __parseStatements("else");
                }
                ifFalse = asg.popBlock();
            } else {
                ifFalse = asg.createValue(undefined, lexer.getLocation());
            }
            return asg.createIf(condition, ifTrue, ifFalse, lexer.getLocation());
        } else if (peeked == __BENTOSCRIPT_TOKEN.WHILE) {
            lexer.next();
            var condition = __parseCondition();
            asg.pushBlock();
            __parseStatements("while");
            var body = asg.popBlock();
            return asg.createWhile(condition, body, lexer.getLocation());
        } else if (peeked == __BENTOSCRIPT_TOKEN.BUILD) {
            lexer.next();
            var condition = __parseCondition();
            asg.pushBlock();
            __parseStatements("build");
            var body = asg.popBlock();
            return asg.createBuild(condition, body, lexer.getLocation());
        } else if (peeked == __BENTOSCRIPT_TOKEN.USE) {
            lexer.next();
            var condition = __parseCondition();
            asg.pushBlock();
            __parseStatements("use");
            var body = asg.popBlock();
            return asg.createUse(condition, body, lexer.getLocation());
        } else if (peeked == __BENTOSCRIPT_TOKEN.FUN) {
            lexer.next();
            asg.pushFunction();
            if (lexer.peek() != __BENTOSCRIPT_TOKEN.BRACE_LEFT) {
                if (lexer.next() != __BENTOSCRIPT_TOKEN.PAREN_LEFT) {
                    __ex("expected opening '(' after 'fun' keyword");
                }
                while (__isNot(__BENTOSCRIPT_TOKEN.PAREN_RIGHT)) {
                    if (lexer.next() != __BENTOSCRIPT_TOKEN.IDENT) {
                        __ex("expected identifier in function arguments");
                    }
                    asg.allocArg(lexer.getValue(), lexer.getLocation());
                    if (lexer.peek() == __BENTOSCRIPT_TOKEN.COMMA) {
                        lexer.next();
                    }
                }
                if (lexer.next() != __BENTOSCRIPT_TOKEN.PAREN_RIGHT) {
                    __ex("expected closing ')' after function arguments");
                }
            }
            __parseStatements("fn");
            return asg.popFunction();
        } else {
            return __parseAssign();
        }
    };

    /// @ignore
    ///
    /// @param {String} keyword
    /// @return {Struct}
    static __parseStatements = function (keyword) {
        if (lexer.next() != __BENTOSCRIPT_TOKEN.BRACE_LEFT) {
            __ex("expected opening '{' at the start of '", keyword, "' block");
        }
        while (__isNot(__BENTOSCRIPT_TOKEN.BRACE_RIGHT)) {
            __parseStatement();
        }
        if (lexer.next() != __BENTOSCRIPT_TOKEN.BRACE_RIGHT) {
            __ex("expected closing '}' after '", keyword, "' block");
        }
    };

    static __parseCondition = function () {
        return __parseAssign();
    };

    /// @ignore
    ///
    /// @return {Struct}
    static __parseAssign = function () {
        var lhs = __parseOpBitwise();
        var peeked = lexer.peek();
        if (
            peeked == __BENTOSCRIPT_TOKEN.ASSIGN ||
            peeked == __BENTOSCRIPT_TOKEN.ASSIGN_MULTIPLY ||
            peeked == __BENTOSCRIPT_TOKEN.ASSIGN_DIVIDE ||
            peeked == __BENTOSCRIPT_TOKEN.ASSIGN_SUBTRACT ||
            peeked == __BENTOSCRIPT_TOKEN.ASSIGN_PLUS
        ) {
            lexer.next();
            var assignType = __BentoScript_operator_assign_from_token(peeked);
            lhs = asg.createAssign(
                assignType,
                lhs,
                __parseExpression(),
                lexer.getLocation()
            );
        }
        return lhs;
    };

    /// @ignore
    ///
    /// @return {Struct}
    static __parseOpBitwise = function () {
        var result = __parseOpBitwiseShift();
        while (true) {
            var peeked = lexer.peek();
            if (
                peeked == __BENTOSCRIPT_TOKEN.BITWISE_AND ||
                peeked == __BENTOSCRIPT_TOKEN.BITWISE_XOR ||
                peeked == __BENTOSCRIPT_TOKEN.BITWISE_OR
            ) {
                lexer.next();
                var op = __BentoScript_operator_from_token(peeked);
                var lhs = result;
                var rhs = __parseOpBitwiseShift();
                result = asg.createBinary(op, lhs, rhs, lexer.getLocation());
            } else {
                return result;
            }
        }
    };

    /// @ignore
    ///
    /// @return {Struct}
    static __parseOpBitwiseShift = function () {
        var result = __parseOpEquality();
        while (true) {
            var peeked = lexer.peek();
            if (
                peeked == __BENTOSCRIPT_TOKEN.SHIFT_LEFT ||
                peeked == __BENTOSCRIPT_TOKEN.SHIFT_RIGHT
            ) {
                lexer.next();
                var op = __BentoScript_operator_from_token(peeked);
                var lhs = result;
                var rhs = __parseOpEquality();
                result = asg.createBinary(op, lhs, rhs, lexer.getLocation());
            } else {
                return result;
            }
        }
    };

    /// @ignore
    ///
    /// @return {Struct}
    static __parseOpEquality = function () {
        var result = __parseOpRelational();
        while (true) {
            var peeked = lexer.peek();
            if (
                peeked == __BENTOSCRIPT_TOKEN.EQUAL ||
                peeked == __BENTOSCRIPT_TOKEN.NOT_EQUAL
            ) {
                lexer.next();
                var op = __BentoScript_operator_from_token(peeked);
                var lhs = result;
                var rhs = __parseOpRelational();
                result = asg.createBinary(op, lhs, rhs, lexer.getLocation());
            } else {
                return result;
            }
        }
    };

    /// @ignore
    ///
    /// @return {Struct}
    static __parseOpRelational = function () {
        var result = __parseOpAdd();
        while (true) {
            var peeked = lexer.peek();
            if (
                peeked == __BENTOSCRIPT_TOKEN.LESS ||
                peeked == __BENTOSCRIPT_TOKEN.LESS_EQUAL ||
                peeked == __BENTOSCRIPT_TOKEN.GREATER ||
                peeked == __BENTOSCRIPT_TOKEN.GREATER_EQUAL
            ) {
                lexer.next();
                var op = __BentoScript_operator_from_token(peeked);
                var lhs = result;
                var rhs = __parseOpAdd();
                result = asg.createBinary(op, lhs, rhs, lexer.getLocation());
            } else {
                return result;
            }
        }
    };

    /// @ignore
    ///
    /// @return {Struct}
    static __parseOpAdd = function () {
        var result = __parseOpMultiply();
        while (true) {
            var peeked = lexer.peek();
            if (
                peeked == __BENTOSCRIPT_TOKEN.PLUS ||
                peeked == __BENTOSCRIPT_TOKEN.SUBTRACT
            ) {
                lexer.next();
                var op = __BentoScript_operator_from_token(peeked);
                var lhs = result;
                var rhs = __parseOpMultiply();
                result = asg.createBinary(op, lhs, rhs, lexer.getLocation());
            } else {
                return result;
            }
        }
    };

    /// @ignore
    ///
    /// @return {Struct}
    static __parseOpMultiply = function () {
        var result = __parseOpUnary();
        while (true) {
            var peeked = lexer.peek();
            if (
                peeked == __BENTOSCRIPT_TOKEN.MULTIPLY ||
                peeked == __BENTOSCRIPT_TOKEN.DIVIDE ||
                peeked == __BENTOSCRIPT_TOKEN.DIVIDE_INT ||
                peeked == __BENTOSCRIPT_TOKEN.REMAINDER
            ) {
                lexer.next();
                var op = __BentoScript_operator_from_token(peeked);
                var lhs = result;
                var rhs = __parseOpUnary();
                result = asg.createBinary(op, lhs, rhs, lexer.getLocation());
            } else {
                return result;
            }
        }
    };

    /// @ignore
    ///
    /// @return {Struct}
    static __parseOpUnary = function () {
        var peeked = lexer.peek();
        if (
            peeked == __BENTOSCRIPT_TOKEN.NOT ||
            peeked == __BENTOSCRIPT_TOKEN.SUBTRACT ||
            peeked == __BENTOSCRIPT_TOKEN.PLUS
        ) {
            lexer.next();
            var op = __BentoScript_operator_from_token(peeked);
            var value = __parseIndex();
            return asg.createUnary(op, value, lexer.getLocation());
        } else {
            return __parseIndex();
        }
    };

    /// @ignore
    ///
    /// @return {Struct}
    static __parseIndex = function () {
        var result = __parseTerminal();
        while (true) {
            var peeked = lexer.peek();
            if (peeked == __BENTOSCRIPT_TOKEN.PAREN_LEFT) {
                // function call syntax
                lexer.next();
                var args = [];
                while (__isNot(__BENTOSCRIPT_TOKEN.PAREN_RIGHT)) {
                    array_push(args, __parseExpression());
                    if (lexer.peek() == __BENTOSCRIPT_TOKEN.COMMA) {
                        lexer.next();
                    }
                }
                if (lexer.next() != __BENTOSCRIPT_TOKEN.PAREN_RIGHT) {
                    __ex("expected closing ')' after function arguments");
                }
                result = asg.createCall(result, args, lexer.getLocation());
            } else if (peeked == __BENTOSCRIPT_TOKEN.BOX_LEFT) {
                // accessor syntax
                lexer.next();
                var collection = result;
                var key = __parseExpression();
                if (lexer.next() != __BENTOSCRIPT_TOKEN.BOX_RIGHT) {
                    __ex("expected closing ']' after accessor expression");
                }
                result = asg.createAccessor(collection, key, lexer.getLocation());
            } else if (peeked == __BENTOSCRIPT_TOKEN.DOT) {
                // dot accessor syntax
                lexer.next();
                var collection = result;
                if (lexer.next() != __BENTOSCRIPT_TOKEN.IDENT) {
                    __ex("expected identifier after '.' operator");
                }
                var key = asg.createValue(lexer.getValue(), lexer.getLocation());
                result = asg.createAccessor(collection, key, lexer.getLocation());
            } else {
                break;
            }
        }
        return result;
    };

    /// @ignore
    ///
    /// @return {Struct}
    static __parseTerminal = function () {
        var peeked = lexer.peek();
        if (peeked == __BENTOSCRIPT_TOKEN.VALUE) {
            lexer.next();
            return asg.createValue(lexer.getValue(), lexer.getLocation());
        } else if (peeked == __BENTOSCRIPT_TOKEN.IDENT) {
            lexer.next();
            return asg.createGet(lexer.getValue(), lexer.getLocation());
        } else if (peeked == __BENTOSCRIPT_TOKEN.SELF) {
            lexer.next();
            return asg.createSelf(lexer.getLocation());
        } else {
            return __parseGrouping();
        }
    };

    /// @ignore
    ///
    /// @return {Struct}
    static __parseGrouping = function () {
        var peeked = lexer.peek();
        if (peeked == __BENTOSCRIPT_TOKEN.PAREN_LEFT) {
            lexer.next();
            var inner = __parseExpression();
            if (lexer.next() != __BENTOSCRIPT_TOKEN.PAREN_RIGHT) {
                __ex("expected closing ')' after group expression");
            }
            return inner;
        } else if (peeked == __BENTOSCRIPT_TOKEN.BOX_LEFT) {
            lexer.next();
            var values = [];
            while (__isNot(__BENTOSCRIPT_TOKEN.BOX_RIGHT)) {
                array_push(values, __parseExpression());
                if (lexer.peek() == __BENTOSCRIPT_TOKEN.COMMA) {
                    lexer.next();
                }
            }
            if (lexer.next() != __BENTOSCRIPT_TOKEN.BOX_RIGHT) {
                __ex("expected closing ']' after array literal");
            }
            return asg.createArray(values, lexer.getLocation());
        } else if (peeked == __BENTOSCRIPT_TOKEN.BRACE_LEFT) {
            lexer.next();
            var values = [];
            while (__isNot(__BENTOSCRIPT_TOKEN.BRACE_RIGHT)) {
                var key;
                var keyToken = lexer.next();
                if (keyToken == __BENTOSCRIPT_TOKEN.BOX_LEFT) {
                    key = __parseExpression();
                    if (lexer.next() != __BENTOSCRIPT_TOKEN.BOX_RIGHT) {
                        __ex(
                            "expected closing ']' after computed struct key"
                        );
                    }
                } else if (
                    keyToken == __BENTOSCRIPT_TOKEN.IDENT ||
                    keyToken == __BENTOSCRIPT_TOKEN.VALUE
                ) {
                    key = asg.createValue(lexer.getValue(), lexer.getLocation());
                } else {
                    __ex("expected identifier or value as struct key");
                }
                var value;
                if (lexer.peek() == __BENTOSCRIPT_TOKEN.COLON) {
                    lexer.next();
                    value = __parseExpression();
                } else if (keyToken == __BENTOSCRIPT_TOKEN.IDENT) {
                    value = asg.createGet(key.value, lexer.getLocation());
                } else {
                    __ex(
                        "expected ':' between key and value ",
                        "of struct literal"
                    );
                }
                if (lexer.peek() == __BENTOSCRIPT_TOKEN.COMMA) {
                    lexer.next();
                }
                array_push(values, key, value);
            }
            if (lexer.next() != __BENTOSCRIPT_TOKEN.BRACE_RIGHT) {
                __ex("expected closing '}' after struct literal");
            }
            return asg.createStruct(values, lexer.getLocation());
        } else {
            __ex("malformed expression, expected: '(', '[' or '{'");
        }
    };

    /// @ignore
    ///
    /// @param {String} ...
    static __ex = function () {
        var dbg = __BentoScriptLocationShow(lexer.getLocation()) + " when parsing";
        if (argument_count < 1) {
            __BentoScriptError(dbg);
        } else {
            var msg = "";
            for (var i = 0; i < argument_count; i += 1) {
                msg += __BentoScriptString(argument[i]);
            }
            __BentoScriptError(dbg, " -- ", msg, ", got ", __tokenDebug());
        }
    };

    /// @ignore
    ///
    /// @return {String}
    static __tokenDebug = function () {
        var peeked = lexer.peek();
        if (peeked == __BENTOSCRIPT_TOKEN.EOF) {
            return "end of file";
        } else if (peeked == __BENTOSCRIPT_TOKEN.SEMICOLON) {
            return "line break ';'";
        }
        return "token '" + lexer.getLexeme() + "' (" + string(peeked) + ")";
    };

    /// @ignore
    ///
    /// @param {Enum.__BENTOSCRIPT_TOKEN} expect
    /// @return {Bool}
    static __isNot = function (expect) {
        var peeked = lexer.peek();
        return peeked != expect && peeked != __BENTOSCRIPT_TOKEN.EOF;
    };

    /// @ignore
    ///
    /// @param {Enum.__BENTOSCRIPT_TOKEN} expect
    /// @return {Bool}
    static __is = function (expect) {
        var peeked = lexer.peek();
        return peeked == expect && peeked != __BENTOSCRIPT_TOKEN.EOF;
    };
}