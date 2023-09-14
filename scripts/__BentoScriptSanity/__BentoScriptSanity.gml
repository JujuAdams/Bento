//! Internal sanity checking module for catching bugs early.

//# feather use syntax-errors

/// @ignore
///
/// @param {Any} val
function __BentoScriptIsWithable(val) {
    if (is_struct(val) || val == self || val == other) {
        return true;
    }
    var isInst = false;
    try {
        isInst = !object_exists(val) && instance_exists(val);
    } catch (_) { }
    return isInst;
}

/// @ignore
///
/// @param {Any} val
function __BentoScriptIsCallable(val) {
    return is_method(val) || is_numeric(val) && script_exists(val);
}

/// @ignore
///
/// @param {Any} val
/// @return {String}
function __BentoScriptString(val) {
    gml_pragma("forceinline");
    return is_string(val) ? val : string(val);
}

/// @ignore
///
/// @param {Any} ...
function __BentoScriptError() {
    var msg = "BentoScript " + __BENTOSCRIPT_VERSION;
    if (argument_count > 0) {
        msg += ": ";
        for (var i = 0; i < argument_count; i += 1) {
            msg += __BentoScriptString(argument[i]);
        }
    }
    show_error(msg, false);
}

/// @ignore
///
/// @param {Any} ...
function __BentoScriptErrorSilent() {
    var msg = "BentoScript " + __BENTOSCRIPT_VERSION;
    if (argument_count > 0) {
        msg += ": ";
        for (var i = 0; i < argument_count; i += 1) {
            msg += __BentoScriptString(argument[i]);
        }
    }
    show_debug_message(msg);
}

/// @ignore
///
/// @param {Any} msg
/// @param {Any} got
function __BentoScriptErrorGot(msg, got) {
    var gotStr;
    if (is_numeric(got)) {
        gotStr = string(got);
    } else if (is_string(got) && string_length(got) < 16) {
        gotStr = got;
    } else {
        gotStr = typeof(got);
    }
    __BentoScriptError(msg, ", got '", gotStr, "'");
}

/// @ignore
function __BentoScriptErrorBug() {
    gml_pragma("forceinline");
    __BentoScriptError(
        "you have likely encountered a compiler bug! ",
        "please get in contact and report this as an issue on the official ",
        "GitHub page: https://github.com/katsaii/bentoScript-lang/issues"
    );
}

/// @ignore
///
/// @param {Any} feature
function __BentoScriptErrorUnimplemented(feature) {
    gml_pragma("forceinline");
    __BentoScriptError(
        "the feature '", feature, "' has not been implemented yet"
    );
}

/// @ignore
function __BentoScriptCheckInit() {
    gml_pragma("forceinline");
    if (__BentoScriptForceInit()) {
        __BentoScriptError(
            "BentoScript was not initialised at this point, make sure to call ",
            "'__BentoScriptForceInit' at the start of your code if you are ",
            "using BentoScript inside of a script resource"
        );
    }
}

/// @ignore
///
/// @param {Function} func
/// @return {String}
function __BentoScriptInferTypeFromPredicate(p) {
    switch (p) {
        case is_string: return "string"; break;
        case is_real: return "real"; break;
        case is_numeric: return "numeric"; break;
        case is_bool: return "bool"; break;
        case is_array: return "array"; break;
        case is_struct: return "struct"; break;
        case is_method: return "method"; break;
        case __BentoScriptIsCallable: return "callable"; break;
        case is_ptr: return "pointer"; break;
        case is_int32: return "int32"; break;
        case is_int64: return "int64"; break;
        case is_undefined: return "undefined"; break;
        case is_nan: return "NaN"; break;
        case is_infinity: return "infinity"; break;
        case buffer_exists: return "buffer"; break;
    }
    return undefined;
}

/// @ignore
///
/// @param {Any} name
/// @param {Any} val
/// @param {Function} func
/// @param {Any} [typeName]
function __BentoScriptCheckArg(name, val, func, typeName=undefined) {
    if (func(val)) {
        return;
    }
    if (typeName == undefined) {
        typeName = __BentoScriptInferTypeFromPredicate(func);
    }
    __BentoScriptError(
        "expected argument '", name, "' to be of type '", typeName, "'",
        ", but got '", typeof(val), "' instead"
    );
}

/// @ignore
///
/// @param {Any} name
/// @param {Any} val
/// @param {Function} func
/// @param {Any} [typeName]
function __BentoScriptCheckArgNot(name, val, func, typeName=undefined) {
    if (!func(val)) {
        return;
    }
    if (typeName == undefined) {
        typeName = __BentoScriptInferTypeFromPredicate(func);
    }
    __BentoScriptError(
        "expected argument '", name,
        "' to be any type EXCEPT of type '", typeName, "'"
    );
}

/// @ignore
///
/// @param {Any} name
/// @param {Any} val
/// @param {Any} ...
function __BentoScriptCheckArgStruct(name, val) {
    __BentoScriptCheckArg(name, val, is_struct);
    for (var i = 2; i < argument_count; i += 2) {
        var varName = argument[i];
        var varFunc = argument[i + 1];
        if (!variable_struct_exists(val, varName)) {
            __BentoScriptError(
                "expected struct argument '", name,
                "' to contain a variable '", varName, "'"
            );
        }
        if (varFunc != undefined) {
            __BentoScriptCheckArg(
                    name + "." + varName, val[$ varName], varFunc);
        }
    }
}

/// @ignore
///
/// @param {Any} name
/// @param {Any} val
/// @param {Any} expect
function __BentoScriptCheckArgStructInstanceOf(name, val, expect) {
    __BentoScriptCheckArg(name, val, is_struct);
    var actual = instanceof(val);
    if (actual != expect) {
        __BentoScriptError(
            "expected struct argument '", name, "' to be an instance of '",
            expect, "', but got '", actual, "'"
        );
    }
}

/// @ignore
///
/// @param {Any} name
/// @param {Any} val
/// @param {Real} size
function __BentoScriptCheckArgSizeBits(name, val, size) {
    gml_pragma("forceinline");
    __BentoScriptCheckArg(name, val, is_numeric);
    if (val < 0) {
        __BentoScriptError("argument '", name, "' must not be negative, got", val);
    }
    if (val >= power(2, size)) {
        __BentoScriptError(
            "argument '", name, "' is too large (", val,
            ") it must fit within ", size, " bits"
        );
    }
}