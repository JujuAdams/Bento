//! Exposes an interface for building and optimising the hierarchial
//! representation of BentoScript programs. Mostly used internally by the
//! BentoScript parser, but could be used yourself to build your own programs
//! from your own domain-specific language.

//# feather use syntax-errors

/// Handles the generation and optimisation of a syntax graph.
///
/// @unstable
function __BentoScriptClassIRBuilder(_environment) constructor {
    self.environment = _environment;
    self.functions = [];
    self.topLevelFunctions = [];
    self.functionScopes = [];
    self.functionScopesTop = -1;
    self.currFunctionScope = undefined;

    /// Returns the underlying syntax graph for this builder.
    ///
    /// @return {Struct}
    static get = function () {
        return {
            functions : functions,
            entryPoints : topLevelFunctions,
            environment : environment,
        };
    };

    /// Emits the instruction to return a new constant value.
    ///
    /// @param {Any} value
    ///   The value this term should resolve to.
    ///
    /// @param {Real} [location]
    ///   The source location of this value term.
    ///
    /// @return {Struct}
    static createValue = function (value, location=undefined) {
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.VALUE, location, {
            value : value
        });
    };

    /// Emits the instruction to create a new array literal.
    ///
    /// @param {Array} values
    ///   The values to populate the array with.
    ///
    /// @param {Real} [location]
    ///   The source location of this value term.
    ///
    /// @return {Struct}
    static createArray = function (values, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArg("values", values, is_array);
        }
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.ARRAY, location, {
            values : values
        });
    };

    /// Emits the instruction to create a new struct literal.
    ///
    /// @param {Array} values
    ///   The key-value pairs to populate the struct with.
    ///
    /// @param {Real} [location]
    ///   The source location of this value term.
    ///
    /// @return {Struct}
    static createStruct = function (values, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArg("values", values, is_array);
            if (array_length(values) % 2 == 1) {
                __BentoScriptError(
                    "expected arg 'values' to be an array with an even ",
                    "number of elements, got ", array_length(values)
                );
            }
        }
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.STRUCT, location, {
            values : values
        });
    };

    /// @ignore
    ///
    /// @param {Struct} term
    /// @return {Any}
    static __getValue = function (term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "value", undefined
            );
        }
        return term.value;
    }

    /// Emits the instruction for an if statement.
    ///
    /// @param {Struct} condition
    ///   The term which evaluates to the condition of the if statement.
    ///
    /// @param {Struct} ifTrue
    ///   The term which evaluates if the condition of the if statement is
    ///   true.
    ///
    /// @param {Struct} ifFalse
    ///   The term which evaluates if the condition of the if statement is
    ///   false.
    ///
    /// @param {Real} [location]
    ///   The source location of this value term.
    ///
    /// @return {Struct}
    static createIf = function (condition, ifTrue, ifFalse, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("condition", condition,
                "type", is_numeric
            );
            __BentoScriptCheckArgStruct("ifFalse", ifFalse,
                "type", is_numeric,
            );
        }
        if (condition.type == __BENTOSCRIPT_TERM.VALUE) {
            if (__getValue(condition)) {
                return ifTrue;
            } else {
                return ifFalse;
            }
        }
        // __createTerm() will do argument validation
        if (ifFalse.type == __BENTOSCRIPT_TERM.VALUE && __getValue(ifFalse) == undefined) {
            return __createTerm(__BENTOSCRIPT_TERM.IF, location, {
                condition : condition,
                ifTrue : ifTrue,
                ifFalse : undefined,
            });
        } else {
            return __createTerm(__BENTOSCRIPT_TERM.IF, location, {
                condition : condition,
                ifTrue : ifTrue,
                ifFalse : ifFalse,
            });
        }
    };

    /// Emits the instruction for a short-circuiting logical AND expression.
    ///
    /// @param {Struct} eager
    ///   The term which evaluates immediately.
    ///
    /// @param {Struct} lazy
    ///   The term which evaluates if the first term is true.
    ///
    /// @param {Real} [location]
    ///   The source location of this value term.
    ///
    /// @return {Struct}
    static createAnd = function (eager, lazy, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("eager", eager,
                "type", is_numeric
            );
        }
        if (eager.type == __BENTOSCRIPT_TERM.VALUE) {
            if (__getValue(condition)) {
                return lazy;
            } else {
                return eager;
            }
        }
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.AND, location, {
            eager : eager,
            lazy : lazy,
        });
    };

    /// Emits the instruction for a short-circuiting logical OR expression.
    ///
    /// @param {Struct} eager
    ///   The term which evaluates immediately.
    ///
    /// @param {Struct} lazy
    ///   The term which evaluates if the first term is false.
    ///
    /// @param {Real} [location]
    ///   The source location of this value term.
    ///
    /// @return {Struct}
    static createOr = function (eager, lazy, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("eager", eager,
                "type", is_numeric
            );
        }
        if (eager.type == __BENTOSCRIPT_TERM.VALUE) {
            if (__getValue(condition)) {
                return eager;
            } else {
                return lazy;
            }
        }
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.OR, location, {
            eager : eager,
            lazy : lazy,
        });
    };

    /// Emits the instruction for a while loop.
    ///
    /// @param {Struct} condition
    ///   The term which evaluates to the condition of the while loop.
    ///
    /// @param {Struct} body
    ///   The body of the while loop.
    ///
    /// @param {Real} [location]
    ///   The source location of this value term.
    ///
    /// @return {Struct}
    static createWhile = function (condition, body, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("condition", condition,
                "type", is_numeric
            );
            __BentoScriptCheckArgStruct("body", body);
        }
        if (condition.type == __BENTOSCRIPT_TERM.VALUE && !__getValue(condition)) {
            return createValue(undefined, condition.dbg);
        }
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.WHILE, location, {
            condition : condition,
            body : body,
        });
    };

    /// Emits the instruction for a context managed `use` block.
    ///
    /// @param {Struct} condition
    ///   The term which evaluates to the condition of the context block.
    ///
    /// @param {Struct} body
    ///   The body of the block.
    ///
    /// @param {Real} [location]
    ///   The source location of this value term.
    ///
    /// @return {Struct}
    static createUse = function (condition, body, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("condition", condition);
            __BentoScriptCheckArgStruct("body", body);
        }
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.USE, location, {
            condition : condition,
            body : body,
        });
    };

    /// Emits the instruction to return a value from the current function.
    ///
    /// @param {Struct} value
    ///   The instruction for the value to return.
    ///
    /// @param {Real} [location]
    ///   The source location of this value term.
    ///
    /// @return {Struct}
    static createReturn = function (value, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("value", value);
        }
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.RETURN, location, {
            value : value
        });
    };

    /// Emits the instruction to break from the current loop with a specified
    /// value.
    ///
    /// @param {Struct} value
    ///   The instruction for the value to break with.
    ///
    /// @param {Real} [location]
    ///   The source location of this value term.
    ///
    /// @return {Struct}
    static createBreak = function (value, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("value", value);
        }
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.BREAK, location, {
            value : value
        });
    };

    /// Emits the instruction to continue to the next iteration of the current
    /// loop.
    ///
    /// @param {Real} [location]
    ///   The source location of this value term.
    ///
    /// @return {Struct}
    static createContinue = function (location=undefined) {
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.CONTINUE, location, { });
    };

    /// Emits the instruction to call a function with a set of arguments.
    ///
    /// @param {Struct} callee
    ///   The instruction containing the function to call.
    ///
    /// @param {Struct} args
    ///   The the arguments to pass into the function call.
    ///
    /// @param {Real} [location]
    ///   The source location of this value term.
    ///
    /// @return {Struct}
    static createCall = function (callee, args, location=undefined) {
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.CALL, location, {
            callee : callee,
            args : args,
        });
    };

    /// Searches a for a variable with the supplied name and emits a get
    /// instruction for it.
    ///
    /// @param {String} name
    ///   The name of the variable to search for.
    ///
    /// @param {Real} [location]
    ///   The source location of this term.
    ///
    /// @return {Struct}
    static createGet = function (name, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArg("name", name, is_string);
        }
        // __createTerm() will do argument validation
        var localIdx = undefined;
        for (var i = currFunctionScope.blocksTop; localIdx == undefined && i >= 0; i -= 1) {
            var scope = currFunctionScope.blocks[i].locals;
            localIdx = scope[$ name];
        }
        if (localIdx == undefined) {
            return __createTerm(__BENTOSCRIPT_TERM.NAKED, location, {
                name : name
            });
        } else {
            return __createTerm(__BENTOSCRIPT_TERM.LOCAL, location, {
                idx : localIdx
            });
        }
    };

    /// Creates an accessor expression.
    ///
    /// @param {Struct} collection
    ///   The term containing the collection to access.
    ///
    /// @param {Struct} key
    ///   The term containing the key to access the collection with.
    ///
    /// @param {Real} [location]
    ///   The source location of this term.
    ///
    /// @return {Struct}
    static createAccessor = function (collection, key, location=undefined) {
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.INDEX, location, {
            collection : collection,
            key : key,
        });
    };

    /// Creates a binary operator.
    ///
    /// @param {Enum.__BENTOSCRIPT_OPERATOR} operator
    ///   The operator type to use.
    ///
    /// @param {String} lhs
    ///   The left-hand side operand.
    ///
    /// @param {String} rhs
    ///   The right-hand side operand.
    ///
    /// @param {Real} [location]
    ///   The source location of this term.
    ///
    /// @return {Struct}
    static createBinary = function (operator, lhs, rhs, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArg("operator", operator, is_numeric); // TODO :: proper bounds check
            __BentoScriptCheckArgStruct("lhs", lhs, "type", is_numeric);
            __BentoScriptCheckArgStruct("rhs", rhs, "type", is_numeric);
        }
        if (lhs.type == __BENTOSCRIPT_TERM.VALUE && rhs.type == __BENTOSCRIPT_TERM.VALUE) {
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArgStruct("lhs", lhs, "value", undefined);
                __BentoScriptCheckArgStruct("rhs", rhs, "value", undefined);
            }
            // constant folding
            var opFunc = __BentoScript_operator_get_binary(operator);
            lhs.value = opFunc(lhs.value, rhs.value);
            return lhs;
        }
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.OP_BINARY, location, {
            operator : operator,
            lhs : lhs,
            rhs : rhs,
        });
    };

    /// Creates a binary operator.
    ///
    /// @param {Enum.__BENTOSCRIPT_OPERATOR} operator
    ///   The operator type to use.
    ///
    /// @param {String} value
    ///   The value to apply the operator to.
    ///
    /// @param {Real} [location]
    ///   The source location of this term.
    ///
    /// @return {Struct}
    static createUnary = function (operator, value, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArg("operator", operator, is_numeric); // TODO :: proper bounds check
            __BentoScriptCheckArgStruct("value", value, "type", is_numeric);
        }
        if (value.type == __BENTOSCRIPT_TERM.VALUE) {
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArgStruct("value", value, "value", undefined);
            }
            // constant folding
            var opFunc = __BentoScript_operator_get_unary(operator);
            value.value = opFunc(value.value);
            return value;
        }
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.OP_UNARY, location, {
            operator : operator,
            value : value,
        });
    };

    /// Creates an instruction for accessing the caller `self`.
    ///
    /// @param {Real} [location]
    ///   The source location of this term.
    ///
    /// @return {Struct}
    static createSelf = function (location=undefined) {
        // __createTerm() will do argument validation
        return __createTerm(__BENTOSCRIPT_TERM.SELF, location, { });
    };

    /// Attempts to assign a right-hand-side value to a left-hand-side target.
    ///
    /// NOTE: Either terms A or B could be optimised or modified, therefore
    ///       you should always treat both terms as being invalid after
    ///       calling this method. Always use the result returned by this
    ///       method as the new source of truth.
    ///
    /// @param {Enum.__BENTOSCRIPT_ASSIGN} type
    ///   The assignment type to use.
    ///
    /// @param {Struct} lhs
    ///   The assignment target to use. Typically this is a local/global
    ///   variable get expression.
    ///
    /// @param {Struct} rhs
    ///   The assignment target to use. Typically this is a local/global
    ///   variable get expression.
    ///
    /// @param {Real} [location]
    ///   The source location of this assignment.
    ///
    /// @return {Struct}
    static createAssign = function (type, lhs, rhs, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArg("type", type, is_numeric);
        }
        if (type == __BENTOSCRIPT_ASSIGN.VANILLA) {
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArgStruct("lhs", lhs,
                    "type", is_numeric
                );
                __BentoScriptCheckArgStruct("rhs", rhs,
                    "type", is_numeric
                );
            }
            var lhsType = lhs.type;
            if (lhsType == __BENTOSCRIPT_TERM.LOCAL) {
                if (rhs.type == __BENTOSCRIPT_TERM.LOCAL) {
                    if (BENTOSCRIPT_DEBUG_MODE) {
                        __BentoScriptCheckArgStruct("lhs", lhs, "idx", is_numeric);
                        __BentoScriptCheckArgStruct("rhs", rhs, "idx", is_numeric);
                    }
                    if (lhs.idx == rhs.idx) {
                        return createValue(undefined, location);
                    }
                }
            } else if (lhsType == __BENTOSCRIPT_TERM.NAKED) {
                if (rhs.type == __BENTOSCRIPT_TERM.NAKED) {
                    if (BENTOSCRIPT_DEBUG_MODE) {
                        __BentoScriptCheckArgStruct("lhs", lhs, "name", is_string);
                        __BentoScriptCheckArgStruct("rhs", rhs, "name", is_string);
                    }
                    if (lhs.name == rhs.name) {
                        return createValue(undefined, location);
                    }
                }
            }
        }
        return __createTerm(__BENTOSCRIPT_TERM.SET, location, {
            assignType : type,
            target : lhs,
            value : rhs,
        });
    };

    /// Adds an existing node to the current block's statement list.
    ///
    /// @param {Struct} term
    ///   The term to register to the current block.
    static createStatement = function (term) {
        var block = currFunctionScope.blocks[currFunctionScope.blocksTop];
        var result_ = block.result;
        if (result_ != undefined) {
            array_push(block.inheritedTerms ?? block.terms, result_);
        }
        block.result = term;
    };

    /// Allocates a new local variable with the supplied name in the current
    /// scope. Returns a term to get or set the value of this local variable.
    ///
    /// @param {String} name
    ///   The name of the local variable to allocate.
    ///
    /// @param {Real} [location]
    ///   The source location of this local variable.
    ///
    /// @return {Struct}
    static allocLocal = function (name, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArg("name", name, is_string);
        }
        // __createTerm() will do argument validation
        var block = currFunctionScope.blocks[currFunctionScope.blocksTop];
        var scope = block.locals;
        if (variable_struct_exists(scope, name)) {
            __BentoScriptError(
                __BentoScriptLocationShow(location),
                " -- a local variable with the name '", name, "' is already ",
                "defined in this scope"
            );
        }
        block.localCount += 1;
        var localIdx = currFunctionScope.nextLocalIdx;
        var nextLocalIdx_ = localIdx + 1;
        currFunctionScope.nextLocalIdx = nextLocalIdx_;
        if (nextLocalIdx_ > currFunctionScope.localCount) {
            currFunctionScope.localCount = nextLocalIdx_;
        }
        scope[$ name] = localIdx;
        return __createTerm(__BENTOSCRIPT_TERM.LOCAL, location, {
            idx : localIdx
        });
    };

    /// Allocates a new named function argument with the supplied name.
    /// Returns a term to get or set the value of this argument.
    ///
    /// @param {String} name
    ///   The name of the local variable to allocate.
    ///
    /// @param {Real} [location]
    ///   The source location of this local variable.
    ///
    /// @return {Struct}
    static allocArg = function (name, location=undefined) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArg("name", name, is_string);
        }
        // __createTerm() will do argument validation
        var local = allocLocal(name, location);
        if (currFunctionScope.argCount != local.idx) {
            __BentoScriptError(
                "must allocate all function arguments before ",
                "allocating any local variables"
            );
        }
        currFunctionScope.argCount += 1;
        return local;
    };

    /// Starts a new local variable block scope. Any local variables
    /// allocated in this scope will be cleared after [popBlock] is
    /// called.
    ///
    /// @param {Bool} [inherit]
    ///   Whether to write terms to the parent block or not. Defaults to
    ///   `false`, which will always create a new block term per local
    ///   scope.
    static pushBlock = function (inherit=false) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArg("inherit", inherit, is_numeric);
        }
        var blocks_ = currFunctionScope.blocks;
        var blocksTop_ = currFunctionScope.blocksTop + 1;
        currFunctionScope.blocksTop = blocksTop_;
        var inheritedTerms = undefined;
        if (inherit) {
            var blockParent = blocks_[blocksTop_ - 1];
            inheritedTerms = blockParent.inheritedTerms ?? blockParent.terms;
        }
        if ((blocksTop_ < 0) || (blocksTop_ >= array_length(blocks_))) {
            array_push(blocks_, {
                locals : {},
                terms : [],
                inheritedTerms : inheritedTerms,
                result : undefined,
                localCount : 0,
            });
        } else {
            var block = blocks_[blocksTop_];
            block.locals = {};
            array_resize(block.terms, 0);
            block.inheritedTerms = inheritedTerms;
            block.result = undefined;
            block.localCount = 0;
        }
    };

    /// Clears the most recent local scope and frees any allocated local
    /// variables.
    ///
    /// @param {Real} [location]
    ///   The source location of this block.
    ///
    /// @return {Struct}
    static popBlock = function (location=undefined) {
        // __createTerm() will do argument validation
        var block = currFunctionScope.blocks[currFunctionScope.blocksTop];
        currFunctionScope.nextLocalIdx -= block.localCount;
        currFunctionScope.blocksTop -= 1;
        var result_ = block.result;
        if (block.inheritedTerms != undefined) {
            return result_ ?? createValue(undefined, location);
        }
        var terms = block.terms;
        if (result_!= undefined) {
            // since the result is separate from the other statements,
            // add it back
            array_push(terms, result_);
        }
        var termCount = array_length(terms);
        var finalTerms = array_create(termCount);
        var finalCount = 0;
        var prevTermIsPure = false;
        for (var i = 0; i < termCount; i += 1) {
            var term = terms[i];
            if (prevTermIsPure) {
                finalCount -= 1;
            }
            finalTerms[@ finalCount] = term;
            finalCount += 1;
            prevTermIsPure = __BentoScriptTermIsPure(term.type);
        }
        if (finalCount == 0) {
            return createValue(undefined, location);
        } else if (finalCount == 1) {
            return finalTerms[0];
        } else {
            var blockLocation = location ?? terms[0].dbg;
            array_resize(finalTerms, finalCount);
            return __createTerm(__BENTOSCRIPT_TERM.BLOCK, blockLocation, {
                terms : finalTerms,
            });
        }
    };

    /// Begins a new BentoScript function scope.
    static pushFunction = function () {
        var functionScopes_ = functionScopes;
        var functionScopesTop_ = functionScopesTop + 1;
        functionScopesTop = functionScopesTop_;
        if ((functionScopesTop_ < 0) || (functionScopesTop_ >= array_length(functionScopes_))) {
            function_ = {
                blocks : [],
                blocksTop : -1,
                nextLocalIdx : 0,
                localCount : 0,
                argCount : 0,
            };
            array_push(functionScopes_, function_);
        } else {
            var function_ = functionScopes_[functionScopesTop_];
            array_resize(function_.blocks, 0);
            function_.blocksTop = -1;
            function_.nextLocalIdx = 0;
            function_.localCount = 0;
            function_.argCount = 0;
        }
        currFunctionScope = function_;
        pushBlock();
    };

    /// Finalises a BentoScript function and inserts it into the list of
    /// known functionScopes and returns its term.
    ///
    /// @param {Real} [location]
    ///   The source location of this function definition.
    ///
    /// @return {Struct}
    static popFunction = function (location=undefined) {
        // __createTerm() will do argument validation
        var idx = array_length(functions);
        functions[@ idx] = {
            localCount : currFunctionScope.localCount,
            argCount : currFunctionScope.argCount,
            root : popBlock(),
        };
        functionScopesTop -= 1;
        if (functionScopesTop < 0) {
            array_push(topLevelFunctions, idx);
            currFunctionScope = undefined;
        } else {
            currFunctionScope = functionScopes[functionScopesTop];
        }
        return __createTerm(__BENTOSCRIPT_TERM.FUNCTION, location, {
            idx : idx,
        });
    };

    /// @ignore
    ///
    /// @param {Enum.__BENTOSCRIPT_TERM} kind
    /// @param {Real} location
    /// @param {Struct} container
    /// @return {Struct}
    static __createTerm = function (kind, location, container) {
        if (BENTOSCRIPT_DEBUG_MODE && location != undefined) {
            __BentoScriptCheckArgSizeBits("location", location, 32);
        }
        container.type = kind;
        container.dbg = location;
        return container;
    };
}

/// @ignore
///
/// @param {Enum.__BENTOSCRIPT_TERM} kind
/// @return {Bool}
function __BentoScriptTermIsPure(kind) {
    return kind == __BENTOSCRIPT_TERM.VALUE ||
            kind == __BENTOSCRIPT_TERM.LOCAL ||
            kind == __BENTOSCRIPT_TERM.NAKED ||
            kind == __BENTOSCRIPT_TERM.FUNCTION ||
            kind == __BENTOSCRIPT_TERM.SELF;
}

/// @ignore
///
/// @param {Struct} term
/// @return {Any}
function __BentoScriptTermGetTerminal(term) {
    if (BENTOSCRIPT_DEBUG_MODE) {
        __BentoScriptCheckArgStruct("term", term,
            "type", is_numeric
        );
    }
    if (term.type == __BENTOSCRIPT_TERM.NAKED) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "name", undefined
            );
        }
        return term.name;
    } else if (term.type == __BENTOSCRIPT_TERM.SELF) {
        return "self";
    } else if (term.type == __BENTOSCRIPT_TERM.VALUE) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "value", undefined
            );
        }
        return string(term.value);
    }
    return undefined;
}

/// Indicates the type of term within a BentoScript syntax graph.
enum __BENTOSCRIPT_TERM {
    VALUE,     // 0
    ARRAY,     // 1
    STRUCT,    // 2
    BLOCK,     // 3
    IF,        // 4
    AND,       // 5
    OR,        // 6
    WHILE,     // 7
    USE,       // 8
    RETURN,    // 9
    BREAK,     //10
    CONTINUE,  //11
    OP_BINARY, //12
    OP_UNARY,  //13
    CALL,      //14
    CALL_NEW,  //15
    SET,       //16
    INDEX,     //17
    LOCAL,     //18
    NAKED,     //29
    FUNCTION,  //20
    SELF,      //21
    __SIZE__   //22
}