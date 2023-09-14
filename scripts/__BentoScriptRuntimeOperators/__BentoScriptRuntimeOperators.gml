//! BentoScript operator database.

//# feather use syntax-errors

/// Represents the set of pure operators used by the BentoScript runtime and
/// compile-time constant folding.
enum __BENTOSCRIPT_OPERATOR {
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
    __SIZE__,
}

/// Represents the set of assignment operators understood by __BentoScript.
enum __BENTOSCRIPT_ASSIGN {
    /// The typical `=` assignment.
    VANILLA,
    /// Multiply assign `*=`.
    MULTIPLY,
    /// Division assign `/=`.
    DIVIDE,
    /// Subtract assign `-=`.
    SUBTRACT,
    /// Plus assign `+=`.
    PLUS,
    __SIZE__,
}

/// @ignore
///
/// @param {Enum.__BENTOSCRIPT_TOKEN} token
/// @return {Enum.__BENTOSCRIPT_OPERATOR}
function __BentoScript_operator_from_token(token) {
    return token - __BENTOSCRIPT_TOKEN.__OP_BEGIN__ - 1;
}

/// @ignore
///
/// @param {Enum.__BENTOSCRIPT_TOKEN} token
/// @return {Enum.__BENTOSCRIPT_ASSIGN}
function __BentoScript_operator_assign_from_token(token) {
    return token - __BENTOSCRIPT_TOKEN.__OP_ASSIGN_BEGIN__ - 1;
}

/// @ignore
///
/// @param {Enum.__BENTOSCRIPT_OPERATOR} op
/// @return {Function}
function __BentoScript_operator_get_binary(op) {
    static _global = __BentoScriptGMLGlobal();
    var opFunc = _global.__bentoScriptBinOps[op];
    if (BENTOSCRIPT_DEBUG_MODE && opFunc == undefined) {
        __BentoScriptErrorBug();
    }
    return opFunc;
}

/// @ignore
///
/// @param {Enum.__BENTOSCRIPT_OPERATOR} op
/// @return {Function}
function __BentoScript_operator_get_unary(op) {
    static _global = __BentoScriptGMLGlobal();
    var opFunc = _global.__bentoScriptUnaryOps[op];
    if (BENTOSCRIPT_DEBUG_MODE && opFunc == undefined) {
        __BentoScriptErrorBug();
    }
    return opFunc;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_remainder(lhs, rhs) {
    return lhs % rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_multiply(lhs, rhs) {
    return lhs * rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_divide(lhs, rhs) {
    return lhs / rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_divide_int(lhs, rhs) {
    return lhs div rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_subtract(lhs, rhs) {
    return lhs - rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_plus(lhs, rhs) {
    return lhs + rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_equal(lhs, rhs) {
    return lhs == rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_not_equal(lhs, rhs) {
    return lhs != rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_greater(lhs, rhs) {
    return lhs > rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_greater_equal(lhs, rhs) {
    return lhs >= rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_less(lhs, rhs) {
    return lhs < rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_less_equal(lhs, rhs) {
    return lhs <= rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_shift_right(lhs, rhs) {
    return lhs >> rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_shift_left(lhs, rhs) {
    return lhs << rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_bitwise_and(lhs, rhs) {
    return lhs & rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_bitwise_xor(lhs, rhs) {
    return lhs ^ rhs;
}

/// @ignore
///
/// @param {Any} lhs
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_bitwise_or(lhs, rhs) {
    return lhs | rhs;
}

/// @ignore
///
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_subtract_unary(rhs) {
    return -rhs;
}

/// @ignore
///
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_plus_unary(rhs) {
    return +rhs;
}

/// @ignore
///
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_not_unary(rhs) {
    return !rhs;
}

/// @ignore
///
/// @param {Any} rhs
/// @return {Any}
function __BentoScript_op_bitwise_not_unary(rhs) {
    return ~rhs;
}

/// @ignore
function __BentoScriptInitOperators() {
    static _global = __BentoScriptGMLGlobal();
    var binOps = array_create(__BENTOSCRIPT_OPERATOR.__SIZE__, undefined);
    var unaryOps = array_create(__BENTOSCRIPT_OPERATOR.__SIZE__, undefined);
    binOps[@ __BENTOSCRIPT_OPERATOR.REMAINDER] = __BentoScript_op_remainder;
    binOps[@ __BENTOSCRIPT_OPERATOR.MULTIPLY] = __BentoScript_op_multiply;
    binOps[@ __BENTOSCRIPT_OPERATOR.DIVIDE] = __BentoScript_op_divide;
    binOps[@ __BENTOSCRIPT_OPERATOR.DIVIDE_INT] = __BentoScript_op_divide_int;
    binOps[@ __BENTOSCRIPT_OPERATOR.SUBTRACT] = __BentoScript_op_subtract;
    binOps[@ __BENTOSCRIPT_OPERATOR.PLUS] = __BentoScript_op_plus;
    binOps[@ __BENTOSCRIPT_OPERATOR.EQUAL] = __BentoScript_op_equal;
    binOps[@ __BENTOSCRIPT_OPERATOR.NOT_EQUAL] = __BentoScript_op_not_equal;
    binOps[@ __BENTOSCRIPT_OPERATOR.GREATER] = __BentoScript_op_greater;
    binOps[@ __BENTOSCRIPT_OPERATOR.GREATER_EQUAL] = __BentoScript_op_greater_equal;
    binOps[@ __BENTOSCRIPT_OPERATOR.LESS] = __BentoScript_op_less;
    binOps[@ __BENTOSCRIPT_OPERATOR.LESS_EQUAL] = __BentoScript_op_less_equal;
    binOps[@ __BENTOSCRIPT_OPERATOR.SHIFT_RIGHT] = __BentoScript_op_shift_right;
    binOps[@ __BENTOSCRIPT_OPERATOR.SHIFT_LEFT] = __BentoScript_op_shift_left;
    binOps[@ __BENTOSCRIPT_OPERATOR.BITWISE_AND] = __BentoScript_op_bitwise_and;
    binOps[@ __BENTOSCRIPT_OPERATOR.BITWISE_XOR] = __BentoScript_op_bitwise_xor;
    binOps[@ __BENTOSCRIPT_OPERATOR.BITWISE_OR] = __BentoScript_op_bitwise_or;
    unaryOps[@ __BENTOSCRIPT_OPERATOR.SUBTRACT] = __BentoScript_op_subtract_unary;
    unaryOps[@ __BENTOSCRIPT_OPERATOR.PLUS] = __BentoScript_op_plus_unary;
    unaryOps[@ __BENTOSCRIPT_OPERATOR.NOT] = __BentoScript_op_not_unary;
    unaryOps[@ __BENTOSCRIPT_OPERATOR.BITWISE_NOT] = __BentoScript_op_bitwise_not_unary;
    /// @ignore
    _global.__bentoScriptBinOps = binOps;
    /// @ignore
    _global.__bentoScriptUnaryOps = unaryOps;
}