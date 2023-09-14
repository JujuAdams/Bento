//! Responsible for the lexical analysis stage of the BentoScript compiler.

//# feather use syntax-errors

/// A token in BentoScript is a series of characters with meaning, usually
/// separated by whitespace.
///
/// For example, these are all valid tokens:
///   - `if`   (is a `__BENTOSCRIPT_TOKEN.IF`)
///   - `else` (is a `__BENTOSCRIPT_TOKEN.ELSE`)
///   - `12.3` (is a `__BENTOSCRIPT_TOKEN.VALUE`)
///   - `+`    (is a `__BENTOSCRIPT_TOKEN.PLUS`)
///
/// The following enum represents all possible token types understood by the
/// BentoScript language.
enum __BENTOSCRIPT_TOKEN {
    /// The `(` character.
    PAREN_LEFT,
    /// The `)` character.
    PAREN_RIGHT,
    /// The `[` character.
    BOX_LEFT,
    /// The `]` character.
    BOX_RIGHT,
    /// The `{` character.
    BRACE_LEFT,
    /// The `}` character.
    BRACE_RIGHT,
    /// The `:` character.
    COLON,
    /// Represents a sequence of `;` characters.
    SEMICOLON,
    /// The `,` character.
    COMMA,
    /// The `.` operator.
    DOT,
    __OP_ASSIGN_BEGIN__,
    /// The `=` operator.
    ASSIGN,
    /// The `*=` operator.
    ASSIGN_MULTIPLY,
    /// The `/=` operator.
    ASSIGN_DIVIDE,
    /// The `-=` operator.
    ASSIGN_SUBTRACT,
    /// The `+=` operator.
    ASSIGN_PLUS,
    __OP_BEGIN__,
    /// The remainder `%` operator.
    REMAINDER,
    /// The `*` operator.
    MULTIPLY,
    /// The `/` operator.
    DIVIDE,
    /// The integer division `//` operator.
    DIVIDE_INT,
    /// The `-` operator.
    SUBTRACT,
    /// The `+` operator.
    PLUS,
    /// The `==` operator.
    EQUAL,
    /// The `!=` operator.
    NOT_EQUAL,
    /// The `>` operator.
    GREATER,
    /// The `>=` operator.
    GREATER_EQUAL,
    /// The `<` operator.
    LESS,
    /// The `<=` operator.
    LESS_EQUAL,
    /// The logical negation `!` operator.
    NOT,
    /// The bitwise negation `~` operator.
    BITWISE_NOT,
    /// The bitwise right shift `>>` operator.
    SHIFT_RIGHT,
    /// The bitwise left shift `<<` operator.
    SHIFT_LEFT,
    /// The bitwise and `&` operator.
    BITWISE_AND,
    /// The bitwise xor `^` operator.
    BITWISE_XOR,
    /// The bitwise or `|` operator.
    BITWISE_OR,
    /// The logical `and` operator.
    AND,
    /// The logical `or` operator.
    OR,
    /// The functional pipe right `|>` operator.
    PIPE_RIGHT,
    /// The functional pipe left `<|` operator.
    PIPE_LEFT,
    /// The `do` keyword.
    DO,
    /// The `if` keyword.
    IF,
    /// The `else` keyword.
    ELSE,
    /// The `while` keyword.
    WHILE,
    /// The `for` keyword.
    FOR,
    /// The `loop` keyword.
    LOOP,
    /// The `use` keyword.
    USE,
    /// The `let` keyword.
    LET,
    /// The `fun` keyword.
    FUN,
    /// The `break` keyword.
    BREAK,
    /// The `continue` keyword.
    CONTINUE,
    /// The `return` keyword.
    RETURN,
    /// The `new` keyword.
    NEW,
    /// The `impl` keyword.
    IMPL,
    /// The `self` keyword.
    SELF,
    /// The `params` keyword.
    PARAMS,
    /// Represents a variable name.
    IDENT,
    /// Represents a GML value. This could be one of:
    ///  - string literal:    "hello world"
    ///  - verbatim literal:  @"\(0_0)/ no escapes!"
    ///  - integer:           1, 2, 5
    ///  - float:             1.25, 0.5
    ///  - character:         'A', '0', '\n'
    ///  - boolean:           true or false
    ///  - undefined
    VALUE,
    /// Represents a sequence of non-breaking whitespace characters.
    WHITESPACE,
    /// Represents a comment.
    COMMENT,
    /// Represents the end of the file.
    EOF,
    /// Represents any other unrecognised character.
    OTHER,
    __SIZE__
}

/// @ignore
///
/// @param {Any} val
function __BentoScriptIsToken(val) {
    // the user can modify what keywords are, so just check
    // that they've used one of the enum types instead of a
    // random ass value
    return is_numeric(val) && (
        val >= 0 && val < __BENTOSCRIPT_TOKEN.__SIZE__
    );
}

/// @ignore
///
/// @param {String} src
/// @return {Id.Buffer}
function __BentoScriptCreateBufferFromString(src) {
    var capacity = string_byte_length(src);
    var buff = buffer_create(capacity, buffer_fixed, 1);
    buffer_write(buff, buffer_text, src);
    buffer_seek(buff, buffer_seek_start, 0);
    return buff;
}

/// Responsible for tokenising the contents of a GML buffer. This can be used
/// for syntax highlighting in a programming game which uses the BentoScript
/// env.
///
/// NOTE: The lexer does not take ownership of this buffer, but it may mutate
///       it so beware. Therefore you should make sure to delete the buffer
///       once parsing is complete.
///
/// @param {Id.Buffer} buff
///   The ID of the GML buffer to use.
///
/// @param {Real} [offset]
///   The offset in the buffer to start parsing from. Defaults to 0.
///
/// @param {Real} [size]
///   The length of the buffer input. Any characters beyond this limit
///   will be treated as the end of the file. Defaults to `infinity`.
///
/// @param {Struct} [keywords]
///   A struct whose keys map to the corresponding BentoScript tokens they
///   represent. Defaults to the vanilla set of BentoScript keywords.
function __BentoScriptClassLexer(
    buff, offset=0, size=infinity, keywords=undefined
) constructor {
    static _global = __BentoScriptGMLGlobal();
    if (BENTOSCRIPT_DEBUG_MODE) {
        __BentoScriptCheckInit();
        __BentoScriptCheckArg("buff", buff, buffer_exists);
        __BentoScriptCheckArg("offset", offset, is_numeric);
        __BentoScriptCheckArg("size", size, is_numeric);
        if (keywords != undefined) {
            __BentoScriptCheckArg("keywords", keywords, is_struct);
        }
    }
    self.buff = buff;
    self.buffAlignment = buffer_get_alignment(buff);
    self.buffCapacity = buffer_get_size(buff);
    self.buffOffset = clamp(offset, 0, self.buffCapacity);
    self.buffSize = clamp(offset + size, 0, self.buffCapacity);
    self.row = 1;
    self.column = 1;
    self.lexemeStart = self.buffOffset;
    self.lexemeEnd = self.lexemeStart;
    self.lexemePos = __BentoScriptLocationCreate(self.row, self.column);
    self.lexeme = undefined;
    self.value = undefined;
    self.hasValue = false;
    self.peeked = undefined;
    self.charCurr = 0;
    //# feather disable once GM2043
    self.charNext = __nextUTF8Char();
    self.keywords = keywords ?? _global.__bentoScriptString2Token;

    /// @ignore
    ///
    /// @return {Real}
    static __nextUTF8Char = function () {
        if (buffOffset >= buffSize) {
            return 0;
        }
        var byte = buffer_peek(buff, buffOffset, buffer_u8);
        buffOffset += 1;
        if ((byte & 0x80) == 0) { // if ((byte & 0b10000000) == 0) {
            // ASCII digit
            return byte;
        }
        var codepointCount;
        var headerMask;
        // parse UTF8 header, could maybe hand-roll a binary search
        if ((byte & 0xFC) == 0xFC) { // if ((byte & 0b11111100) == 0b11111100) {
            codepointCount = 5;
            headerMask = 0xFC;
        } else if ((byte & 0xF8) == 0xF8) { // } else if ((byte & 0b11111000) == 0b11111000) {
            codepointCount = 4;
            headerMask = 0xF8;
        } else if ((byte & 0xF0) == 0xF0) { // } else if ((byte & 0b11110000) == 0b11110000) {
            codepointCount = 3;
            headerMask = 0xF0;
        } else if ((byte & 0xE0) == 0xE0) { // } else if ((byte & 0b11100000) == 0b11100000) {
            codepointCount = 2;
            headerMask = 0xE0;
        } else if ((byte & 0xC0) == 0xC0) { // } else if ((byte & 0b11000000) == 0b11000000) {
            codepointCount = 1;
            headerMask = 0xC0;
        } else {
            //__BentoScriptError("invalid UTF8 header codepoint '", byte, "'");
            return -1;
        }
        // parse UTF8 continuations (2 bit header, followed by 6 bits of data)
        var dataWidth = 6;
        var utf8Value = (byte & ~headerMask) << (codepointCount * dataWidth);
        for (var i = codepointCount - 1; i >= 0; i -= 1) {
            byte = buffer_peek(buff, buffOffset, buffer_u8);
            buffOffset += 1;
            if ((byte & 0x80) == 0) { // if ((byte & 0b10000000) == 0) {
                //__BentoScriptError("invalid UTF8 continuation codepoint '", byte, "'");
                return -1;
            }
            utf8Value |= (byte & ~0xC0) << (i * dataWidth); // utf8Value |= (byte & ~0b11000000) << (i * dataWidth);
        }
        return utf8Value;
    };

    /// @ignore
    static __advance = function () {
        lexemeEnd = buffOffset;
        if (charNext == ord("\r")) {
            column = 1;
            row += 1;
        } else if (charNext == ord("\n")) {
            column = 1;
            if (charCurr != ord("\r")) {
                row += 1;
            }
        } else {
            column += 1;
        }
        // actually update chars now
        charCurr = charNext;
        charNext = __nextUTF8Char();
    };

    /// @ignore
    static __clearLexeme = function () {
        lexemeStart = lexemeEnd;
        lexemePos = __BentoScriptLocationCreate(self.row, self.column);
        lexeme = undefined;
        hasValue = false;
    };

    /// @ignore
    ///
    /// @param {Real} start
    /// @param {Real} end_
    static __slice = function (start, end_) {
        var buff_ = buff;
        // don't read outside bounds of `buffSize`
        var clipStart = min(start, buffSize);
        var clipEnd = min(end_, buffSize);
        if (clipEnd <= clipStart) {
            // always an empty slice
            if (BENTOSCRIPT_DEBUG_MODE && clipEnd < clipStart) {
                __BentoScriptErrorBug();
            }
            return "";
        } else if (clipEnd >= buffCapacity) {
            // beyond the actual capacity of the buffer
            // not safe to use `buffer_string`, which expects a null char
            return buffer_peek(buff_, clipStart, buffer_text);
        } else {
            // quickly write a null terminator and then read the content
            var byte = buffer_peek(buff_, clipEnd, buffer_u8);
            buffer_poke(buff_, clipEnd, buffer_u8, 0x00);
            var result = buffer_peek(buff_, clipStart, buffer_string);
            buffer_poke(buff_, clipEnd, buffer_u8, byte);
            return result;
        }
    };

    /// Returns the string representation of the most recent token emitted by
    /// the [next] or [nextWithWhitespace] methods.
    ///
    /// @example
    ///   Prints the string content of the first [__BENTOSCRIPT_TOKEN] emitted by a
    ///   lexer.
    ///
    /// ```gml
    /// lexer.next();
    /// show_debug_message(lexer.getLexeme());
    /// ```
    ///
    /// @return {String}
    static getLexeme = function () {
        lexeme ??= __slice(lexemeStart, lexemeEnd);
        return lexeme;
    };

    /// @ignore
    ///
    /// @param {String} str
    static __getKeyword = function (str) {
        var keyword = keywords[$ str];
        if (BENTOSCRIPT_DEBUG_MODE && keyword != undefined) {
            __BentoScriptCheckArg(
                    "keyword", keyword, __BentoScriptIsToken, "__BENTOSCRIPT_TOKEN");
        }
        return keyword;
    };

    /// Returns the actual value representation of the most recent token
    /// emitted by the [next] or [nextWithWhitespace] methods.
    ///
    /// NOTE: Unlike [getLexeme] this value is not always a string. For numeric
    ///       literals, the value will be converted into an integer or real.
    ///
    /// @return {Any}
    static getValue = function () {
        if (hasValue) {
            return value;
        }
        value = getLexeme();
        hasValue = true;
        return value;
    };

    /// Returns the location information for the most recent token emitted by
    /// the [next] or [nextWithWhitespace] methods.
    ///
    /// @return {Real}
    static getLocation = function () {
        return __BentoScriptLocationCreate(row, column);
    };

    /// Advances the lexer and returns the next type of [__BENTOSCRIPT_TOKEN]. This
    /// includes additional whitespace and control tokens, like:
    ///  - comments `--`            (`__BENTOSCRIPT_TOKEN.COMMENT`)
    ///
    /// To get the string content of the token, you should use the [getLexeme]
    /// method.
    ///
    /// @example
    ///   Iterates through all tokens of a buffer containing BentoScript code,
    ///   printing each non-whitespace token out as a debug message.
    ///
    /// ```gml
    /// var lexer = new __BentoScriptClassLexer(buff);
    /// do {
    ///   var token = lexer.nextWithWhitespace();
    ///   if (token != __BENTOSCRIPT_TOKEN.WHITESPACE) {
    ///     show_debug_message(lexer.getLexeme());
    ///   }
    /// } until (token == __BENTOSCRIPT_TOKEN.EOF);
    /// ```
    ///
    /// @return {Enum.__BENTOSCRIPT_TOKEN}
    static nextWithWhitespace = function () {
        __clearLexeme();
        if (charNext == 0) {
            return __BENTOSCRIPT_TOKEN.EOF;
        }
        __advance();
        var token = __BENTOSCRIPT_TOKEN.OTHER;
        var charCurr_ = charCurr; // micro-optimisation, locals are faster
        if (charCurr_ >= 0 && charCurr_ < __BENTOSCRIPT_CODEPAGE_SIZE) {
            token = _global.__bentoScriptChar2Token[charCurr_];
        }
        if (
            charCurr_ == ord("\"") ||
            charCurr_ == ord("@") && charNext == ord("\"")
        ) {
            // strings
            var isRaw = charCurr_ == ord("@");
            if (isRaw) {
                token = __BENTOSCRIPT_TOKEN.VALUE; // since `@` is an operator
                __advance();
            }
            var skipNextChar = false;
            var processEscapes = false;
            while (true) {
                var charNext_ = charNext;
                if (charNext_ == 0) {
                    break;
                }
                if (skipNextChar) {
                    __advance();
                    skipNextChar = false;
                    continue;
                }
                if (!isRaw && charNext == ord("\\")) {
                    skipNextChar = true;
                    processEscapes = true;
                } else if (charNext_ == ord("\"")) {
                    break;
                }
                __advance();
            }
            var value_ = __slice(lexemeStart + (isRaw ? 2 : 1), lexemeEnd);
            if (charNext == ord("\"")) {
                __advance();
            }
            if (processEscapes) {
                // TODO :: may be very slow, figure out how to do it faster
                value_ = string_replace_all(value_, "\\\"", "\"");
                value_ = string_replace_all(value_, "\\t", "\t");
                value_ = string_replace_all(value_, "\\n", "\n");
                value_ = string_replace_all(value_, "\\v", "\v");
                value_ = string_replace_all(value_, "\\f", "\f");
                value_ = string_replace_all(value_, "\\r", "\r");
                value_ = string_replace_all(value_, "\\\\", "\\");
            }
            value = value_;
            hasValue = true;
        } else if (__BentoScriptCharIsIsOperator(charCurr_)) {
            // operators
            while (__BentoScriptCharIsIsOperator(charNext)) {
                __advance();
            }
            var keyword = __getKeyword(getLexeme());
            if (keyword != undefined) {
                token = keyword;
                if (keyword == __BENTOSCRIPT_TOKEN.COMMENT) {
                    // consume the comment
                    lexeme = undefined; // since the lexeme is now invalid
                                        // we have more work to do
                    while (true) {
                        var charNext_ = charNext;
                        if (
                            charNext_ == ord("\n") ||
                            charNext_ == ord("\r") ||
                            charNext_ == 0
                        ) {
                            break;
                        }
                        __advance();
                    }
                }
            }
        } else if (charCurr_ == ord("`")) {
            // literal identifiers
            while (true) {
                var charNext_ = charNext;
                if (
                    charNext_ == ord("`") || charNext_ == 0 ||
                    __BentoScriptCharIsIsWhitespace(charNext_)
                ) {
                    break;
                }
                __advance();
            }
            value = __slice(lexemeStart + 1, lexemeEnd);
            hasValue = true;
            if (charNext == ord("`")) {
                __advance();
            }
        } else if (token == __BENTOSCRIPT_TOKEN.IDENT) {
            // alphanumeric identifiers
            while (__BentoScriptCharIsAlphanumeric(charNext)) {
                __advance();
            }
            var lexeme_ = getLexeme();
            var keyword = __getKeyword(lexeme_);
            // TODO :: optimise this into a lookup table?
            if (keyword != undefined) {
                token = keyword;
            } else if (lexeme_ == "true") {
                token = __BENTOSCRIPT_TOKEN.VALUE;
                value = true;
                hasValue = true;
            } else if (lexeme_ == "false") {
                token = __BENTOSCRIPT_TOKEN.VALUE;
                value = false;
                hasValue = true;
            } else if (lexeme_ == "undefined") {
                token = __BENTOSCRIPT_TOKEN.VALUE;
                value = undefined;
                hasValue = true;
            } else if (lexeme_ == "NaN") {
                token = __BENTOSCRIPT_TOKEN.VALUE;
                value = NaN;
                hasValue = true;
            } else if (lexeme_ == "infinity") {
                token = __BENTOSCRIPT_TOKEN.VALUE;
                value = infinity;
                hasValue = true;
            }
        } else if (charCurr_ == ord("'")) {
            // character literals
            __advance();
            value = charCurr;
            hasValue = true;
            if (charNext == ord("'")) {
                __advance();
            }
        } else if (
            charCurr_ == ord("0") &&
            (charNext == ord("x") || charNext == ord("X"))
        ) {
            // hexadecimal literals
            __advance();
            var digitStack = ds_stack_create();
            while (true) {
                var charNext_ = charNext;
                if (__BentoScriptCharIsDigitHex(charNext_)) {
                    ds_stack_push(digitStack,
                            __BentoScriptCharHexToDec(charNext_));
                    __advance();
                } else if (charNext_ == ord("_")) {
                    __advance();
                } else {
                    break;
                }
            }
            value = 0;
            var pow = 0;
            while (!ds_stack_empty(digitStack)) {
                value += power(16, pow) * ds_stack_pop(digitStack);
                pow += 1;
            }
            ds_stack_destroy(digitStack);
            hasValue = true;
        } else if (
            charCurr_ == ord("0") &&
            (charNext == ord("b") || charNext == ord("B"))
        ) {
            // TODO :: avoid code duplication here
            // binary literals
            __advance();
            var digitStack = ds_stack_create();
            while (true) {
                var charNext_ = charNext;
                if (__BentoScriptCharIsDigitBinary(charNext_)) {
                    ds_stack_push(digitStack,
                            __BentoScriptCharBinaryToDec(charNext_));
                    __advance();
                } else if (charNext_ == ord("_")) {
                    __advance();
                } else {
                    break;
                }
            }
            value = 0;
            var pow = 0;
            while (!ds_stack_empty(digitStack)) {
                value += power(2, pow) * ds_stack_pop(digitStack);
                pow += 1;
            }
            ds_stack_destroy(digitStack);
            hasValue = true;
        } else if (charCurr_ == ord("#")) {
            // colour literals
            token = __BENTOSCRIPT_TOKEN.VALUE;
            var digitStack = ds_stack_create();
            while (true) {
                var charNext_ = charNext;
                if (__BentoScriptCharIsDigitHex(charNext_)) {
                    ds_stack_push(digitStack,
                            __BentoScriptCharHexToDec(charNext_));
                    __advance();
                } else if (charNext_ == ord("_")) {
                    __advance();
                } else {
                    break;
                }
            }
            var digitCount = ds_stack_size(digitStack);
            var cR = 0;
            var cG = 0;
            var cB = 0;
            var cA = 0;
            if (digitCount == 3) {
                // #RGB
                cB = ds_stack_pop(digitStack);
                cB = cB | (cB << 4);
                cG = ds_stack_pop(digitStack);
                cG = cG | (cG << 4);
                cR = ds_stack_pop(digitStack);
                cR = cR | (cR << 4);
            } else if (digitCount == 4) {
                // #RGBA
                cA = ds_stack_pop(digitStack);
                cA = cA | (cA << 4);
                cB = ds_stack_pop(digitStack);
                cB = cB | (cB << 4);
                cG = ds_stack_pop(digitStack);
                cG = cG | (cG << 4);
                cR = ds_stack_pop(digitStack);
                cR = cR | (cR << 4);
            } else if (digitCount == 6) {
                // #RRGGBB
                cB = ds_stack_pop(digitStack);
                cB = cB | (ds_stack_pop(digitStack) << 4);
                cG = ds_stack_pop(digitStack);
                cG = cG | (ds_stack_pop(digitStack) << 4);
                cR = ds_stack_pop(digitStack);
                cR = cR | (ds_stack_pop(digitStack) << 4);
            } else if (digitCount == 8) {
                // #RRGGBBAA
                cA = ds_stack_pop(digitStack);
                cA = cA | (ds_stack_pop(digitStack) << 4);
                cB = ds_stack_pop(digitStack);
                cB = cB | (ds_stack_pop(digitStack) << 4);
                cG = ds_stack_pop(digitStack);
                cG = cG | (ds_stack_pop(digitStack) << 4);
                cR = ds_stack_pop(digitStack);
                cR = cR | (ds_stack_pop(digitStack) << 4);
            } else {
                // invalid
                token = __BENTOSCRIPT_TOKEN.OTHER;
            }
            ds_stack_destroy(digitStack);
            value = cR | (cG << 8) | (cB << 16) | (cA << 24);
            hasValue = true;
        } else if (token == __BENTOSCRIPT_TOKEN.VALUE) {
            // numeric literals
            var hasUnderscores = false;
            var hasDecimal = false;
            while (true) {
                var charNext_ = charNext;
                if (__BentoScriptCharIsDigit(charNext_)) {
                    __advance();
                } else if (charNext_ == ord("_")) {
                    __advance();
                    hasUnderscores = true;
                } else if (!hasDecimal && charNext_ == ord(".")) {
                    __advance();
                    hasDecimal = true;
                } else {
                    break;
                }
            }
            var digits = getLexeme();
            if (hasUnderscores) {
                digits = string_replace_all(digits, "_", "");
            }
            value = real(digits);
            hasValue = true;
        }
        return token;
    };

    /// Advances the lexer and returns the next [__BENTOSCRIPT_TOKEN], ingoring
    /// any comments, whitespace, and line continuations.
    ///
    /// To get the string content of the token, you should use the [getLexeme]
    /// method.
    ///
    /// @example
    ///   Iterates through all tokens of a buffer containing BentoScript code,
    ///   printing each token out as a debug message.
    ///
    /// ```gml
    /// var lexer = new __BentoScriptClassLexer(buff);
    /// do {
    ///   var token = lexer.next();
    ///   show_debug_message(lexer.getLexeme());
    /// } until (token == __BENTOSCRIPT_TOKEN.EOF);
    /// ```
    ///
    /// @return {Enum.__BENTOSCRIPT_TOKEN}
    static next = function () {
        if (peeked != undefined) {
            var token = peeked;
            peeked = undefined;
            return token;
        }
        while (true) {
            var token = nextWithWhitespace();
            if (token == __BENTOSCRIPT_TOKEN.WHITESPACE
                    || token == __BENTOSCRIPT_TOKEN.COMMENT) {
                continue;
            }
            return token;
        }
    };

    /// Peeks at the next non-whitespace character without advancing the lexer.
    ///
    /// @example
    ///   Iterates through all tokens of a buffer containing BentoScript code,
    ///   printing each token out as a debug message.
    ///
    /// ```gml
    /// var lexer = new __BentoScriptClassLexer(buff);
    /// while (lexer.peek() != __BENTOSCRIPT_TOKEN.EOF) {
    ///   lexer.next();
    ///   show_debug_message(lexer.getLexeme());
    /// }
    /// ```
    ///
    /// @return {Enum.__BENTOSCRIPT_TOKEN}
    static peek = function () {
        peeked ??= next();
        return peeked;
    };
}

/// @ignore
#macro __BENTOSCRIPT_CODEPAGE_SIZE 256

/// @ignore
function __BentoScriptInitLexer() {
    static _global = __BentoScriptGMLGlobal();
    // initialise map from character to token type
    /// @ignore
    _global.__bentoScriptChar2Token = __BentoScriptInitLexerCodepage();
    /// @ignore
    _global.__bentoScriptString2Token = __BentoScriptInitLexerKeywords();
}

/// @ignore
function __BentoScriptCharIsDigit(char) {
    gml_pragma("forceinline");
    return char >= ord("0") && char <= ord("9");
}

/// @ignore
function __BentoScriptCharIsDigitBinary(char) {
    gml_pragma("forceinline");
    return char == ord("0") || char == ord("1");
}

/// @ignore
function __BentoScriptCharBinaryToDec(char) {
    gml_pragma("forceinline");
    return char == ord("0") ? 0 : 1;
}

/// @ignore
function __BentoScriptCharIsDigitHex(char) {
    gml_pragma("forceinline");
    return char >= ord("a") && char <= ord("f") ||
            char >= ord("A") && char <= ord("F") ||
            char >= ord("0") && char <= ord("9");
}

/// @ignore
function __BentoScriptCharHexToDec(char) {
    if (char >= ord("0") && char <= ord("9")) {
        return char - ord("0");
    }
    if (char >= ord("a") && char <= ord("f")) {
        return char - ord("a") + 10;
    }
    return char - ord("A") + 10;
}

/// @ignore
function __BentoScriptCharIsAlphanumeric(char) {
    gml_pragma("forceinline");
    return char >= ord("a") && char <= ord("z") ||
            char >= ord("A") && char <= ord("Z") ||
            char >= ord("0") && char <= ord("9") ||
            char == ord("_");
}

/// @ignore
function __BentoScriptCharIsIsOperator(char) {
    gml_pragma("forceinline");
    return char >= ord("!") && char <= ord("&") && char != ord("\"") && char != ord("#") ||
            char >= ord("*") && char <= ord("/") && char != ord(",") ||
            char >= ord(":") && char <= ord("@") ||
            char == ord("\\") || char == ord("^") ||
            char == ord("|") || char == ord("~");
}

/// @ignore
function __BentoScriptCharIsIsWhitespace(char) {
    gml_pragma("forceinline");
    return char >= 0x09 && char <= 0x0D || char == 0x20 || char == 0x85;
}

/// @ignore
function __BentoScriptCodepageValue(code) {
    gml_pragma("forceinline");
    return is_string(code) ? ord(code) : code;
}

/// @ignore
function __BentoScriptCodepageRange(code, minCode, maxCode) {
    gml_pragma("forceinline");
    var codeVal = __BentoScriptCodepageValue(code);
    var minVal = __BentoScriptCodepageValue(minCode);
    var maxVal = __BentoScriptCodepageValue(maxCode);
    return codeVal >= minVal && codeVal <= maxVal;
}

/// @ignore
function __BentoScriptCodepageSet(code) {
    gml_pragma("forceinline");
    var codeVal = __BentoScriptCodepageValue(code);
    for (var i = 1; i < argument_count; i += 1) {
        if (codeVal == __BentoScriptCodepageValue(argument[i])) {
            return true;
        }
    }
    return false;
}

/// @ignore
function __BentoScriptInitLexerCodepage() {
    var page = array_create(__BENTOSCRIPT_CODEPAGE_SIZE, __BENTOSCRIPT_TOKEN.OTHER);
    for (var code = 0; code < __BENTOSCRIPT_CODEPAGE_SIZE; code += 1) {
        var tokenType;
        if (__BentoScriptCodepageSet(code,
            0x09, // CHARACTER TABULATION ('\t')
            0x0A, // LINE FEED            ('\n')
            0x0B, // LINE TABULATION      ('\v')
            0x0C, // FORM FEED            ('\f')
            0x0D, // CARRIAGE RETURN      ('\r')
            0x20, // SPACE                (' ')
            0x85  // NEXT LINE
        )) {
            tokenType = __BENTOSCRIPT_TOKEN.WHITESPACE;
        } else if (
            __BentoScriptCodepageRange(code, "a", "z") ||
            __BentoScriptCodepageRange(code, "A", "Z") ||
            __BentoScriptCodepageSet(code, "_", "`") // identifier literals
        ) {
            tokenType = __BENTOSCRIPT_TOKEN.IDENT;
        } else if (
            __BentoScriptCodepageRange(code, "0", "9") ||
            __BentoScriptCodepageSet(code, "'") // character literals
        ) {
            tokenType = __BENTOSCRIPT_TOKEN.VALUE;
        } else if (__BentoScriptCodepageSet(code, "\"")) {
            tokenType = __BENTOSCRIPT_TOKEN.VALUE;
        } else if (__BentoScriptCodepageSet(code, "(")) {
            tokenType = __BENTOSCRIPT_TOKEN.PAREN_LEFT;
        } else if (__BentoScriptCodepageSet(code, ")")) {
            tokenType = __BENTOSCRIPT_TOKEN.PAREN_RIGHT;
        } else if (__BentoScriptCodepageSet(code, "[")) {
            tokenType = __BENTOSCRIPT_TOKEN.BOX_LEFT;
        } else if (__BentoScriptCodepageSet(code, "]")) {
            tokenType = __BENTOSCRIPT_TOKEN.BOX_RIGHT;
        } else if (__BentoScriptCodepageSet(code, "{")) {
            tokenType = __BENTOSCRIPT_TOKEN.BRACE_LEFT;
        } else if (__BentoScriptCodepageSet(code, "}")) {
            tokenType = __BENTOSCRIPT_TOKEN.BRACE_RIGHT;
        } else if (__BentoScriptCodepageSet(code, ",")) {
            tokenType = __BENTOSCRIPT_TOKEN.COMMA;
        } else {
            continue;
        }
        page[@ code] = tokenType;
    }
    return page;
}

/// @ignore
///
/// @return {Struct}
function __BentoScriptKeywordsCreate() {
    var keywords = { };
    keywords[$ "--"] = __BENTOSCRIPT_TOKEN.COMMENT;
    keywords[$ ";"] = __BENTOSCRIPT_TOKEN.SEMICOLON;
    keywords[$ ":"] = __BENTOSCRIPT_TOKEN.COLON;
    keywords[$ ","] = __BENTOSCRIPT_TOKEN.COMMA;
    keywords[$ "."] = __BENTOSCRIPT_TOKEN.DOT;
    keywords[$ "="] = __BENTOSCRIPT_TOKEN.ASSIGN;
    keywords[$ "*="] = __BENTOSCRIPT_TOKEN.ASSIGN_MULTIPLY;
    keywords[$ "/="] = __BENTOSCRIPT_TOKEN.ASSIGN_DIVIDE;
    keywords[$ "-="] = __BENTOSCRIPT_TOKEN.ASSIGN_SUBTRACT;
    keywords[$ "+="] = __BENTOSCRIPT_TOKEN.ASSIGN_PLUS;
    keywords[$ "%"] = __BENTOSCRIPT_TOKEN.REMAINDER;
    keywords[$ "*"] = __BENTOSCRIPT_TOKEN.MULTIPLY;
    keywords[$ "/"] = __BENTOSCRIPT_TOKEN.DIVIDE;
    keywords[$ "//"] = __BENTOSCRIPT_TOKEN.DIVIDE_INT;
    keywords[$ "-"] = __BENTOSCRIPT_TOKEN.SUBTRACT;
    keywords[$ "+"] = __BENTOSCRIPT_TOKEN.PLUS;
    keywords[$ "=="] = __BENTOSCRIPT_TOKEN.EQUAL;
    keywords[$ "!="] = __BENTOSCRIPT_TOKEN.NOT_EQUAL;
    keywords[$ ">"] = __BENTOSCRIPT_TOKEN.GREATER;
    keywords[$ ">="] = __BENTOSCRIPT_TOKEN.GREATER_EQUAL;
    keywords[$ "<"] = __BENTOSCRIPT_TOKEN.LESS;
    keywords[$ "<="] = __BENTOSCRIPT_TOKEN.LESS_EQUAL;
    keywords[$ "!"] = __BENTOSCRIPT_TOKEN.NOT;
    keywords[$ "~"] = __BENTOSCRIPT_TOKEN.BITWISE_NOT;
    keywords[$ ">>"] = __BENTOSCRIPT_TOKEN.SHIFT_RIGHT;
    keywords[$ "<<"] = __BENTOSCRIPT_TOKEN.SHIFT_LEFT;
    keywords[$ "&"] = __BENTOSCRIPT_TOKEN.BITWISE_AND;
    keywords[$ "^"] = __BENTOSCRIPT_TOKEN.BITWISE_XOR;
    keywords[$ "|"] = __BENTOSCRIPT_TOKEN.BITWISE_OR;
    keywords[$ "and"] = __BENTOSCRIPT_TOKEN.AND;
    keywords[$ "or"] = __BENTOSCRIPT_TOKEN.OR;
    keywords[$ "do"] = __BENTOSCRIPT_TOKEN.DO;
    keywords[$ "if"] = __BENTOSCRIPT_TOKEN.IF;
    keywords[$ "else"] = __BENTOSCRIPT_TOKEN.ELSE;
    keywords[$ "while"] = __BENTOSCRIPT_TOKEN.WHILE;
    keywords[$ "for"] = __BENTOSCRIPT_TOKEN.FOR;
    keywords[$ "loop"] = __BENTOSCRIPT_TOKEN.LOOP;
    keywords[$ "use"] = __BENTOSCRIPT_TOKEN.USE;
    keywords[$ "let"] = __BENTOSCRIPT_TOKEN.LET;
    keywords[$ "fun"] = __BENTOSCRIPT_TOKEN.FUN;
    keywords[$ "params"] = __BENTOSCRIPT_TOKEN.PARAMS;
    keywords[$ "break"] = __BENTOSCRIPT_TOKEN.BREAK;
    keywords[$ "continue"] = __BENTOSCRIPT_TOKEN.CONTINUE;
    keywords[$ "return"] = __BENTOSCRIPT_TOKEN.RETURN;
    keywords[$ "self"] = __BENTOSCRIPT_TOKEN.SELF;
    return keywords;
}

/// @ignore
///
/// @param {Struct} keywords
/// @param {String} currentName
/// @param {String} newName
function __BentoScriptKeywordsRename(keywords, currentName, newName) {
    if (!variable_struct_exists(keywords, currentName)) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptErrorSilent(
                "no keyword with the name '", currentName, "' exists"
            );
        }
        return;
    }
    var token = keywords[$ currentName];
    variable_struct_remove(keywords, currentName);
    keywords[$ newName] = token;
}

/// @ignore
///
/// NOTE: This is an O(n) operation. This means that it's slow, and should
///       only be used for debugging purposes.
///
/// @param {Struct} keywords
/// @param {Enum.__BENTOSCRIPT_TOKEN} token
///
/// @return {String}
function __BentoScriptKeywordsFindName(keywords, token) {
    if (BENTOSCRIPT_DEBUG_MODE) {
        __BentoScriptCheckArg("keywords", keywords, is_struct);
        __BentoScriptCheckArg(
                "token", token, __BentoScriptIsToken, "__BENTOSCRIPT_TOKEN");
    }
    var variables = variable_struct_get_names(keywords);
    var variableCount = array_length(variables);
    for (var i = 0; i < variableCount; i += 1) {
        var variable = variables[i];
        if (keywords[$ variable] == token) {
            return variable;
        }
    }
    return undefined;
}

/// @ignore
function __BentoScriptInitLexerKeywords() {
    static _global = __BentoScriptGMLGlobal();
    var keywords = __BentoScriptKeywordsCreate();
    _global.__bentoScriptConfig.keywords = keywords;
    return keywords;
}