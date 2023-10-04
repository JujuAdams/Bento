//! Responsible for the code generation stage of the BentoScript compiler.
//!
//! This stage converts the hierarchical representation of your BentoScript
//! programs, produced by [__BentoScriptClassParser] and [__BentoScriptClassIRBuilder], into
//! various lower-level formats. The most interesting of these formats is
//! the conversion of BentoScript programs into runnable GML functions.

//# feather use syntax-errors

/// @ignore
///
/// @param {Function} func
/// @return {String}
function __BentoScriptInferFunctionName(func) {
    if (is_method(func)) {
        var name = func[$ "name"];
        if (is_string(name)) {
            return name;
        }
        func = method_get_index(func);
    }
    return script_get_name(func);
}

/// Represents a foreign function/constant interface for exposing BentoScript
function __BentoScriptClassForeignInterface() constructor {
    self.database = { };
    self.databaseDynConst = { }; //Contains keywords marked as "dynamic constants"
    self.banList = { };

    /// Returns the value of a foreign symbol exposed to this interface.
    ///
    /// @param {String} name
    ///   The name of the symbol as it appears in __BentoScript.
    ///
    /// @return {Any}
    static get = function (name) {
        if (variable_struct_exists(banList, name)) {
            // this function has been banned!
            return undefined;
        }
        return database[$ name];
    };

    /// Returns whether a foreign symbol is exposed to this interface.
    ///
    /// @param {String} name
    ///   The name of the symbol as it appears in __BentoScript.
    ///
    /// @return {Bool}
    static exists = function (name) {
        if (variable_struct_exists(banList, name)) {
            // this function has been banned!
            return false;
        }
        return variable_struct_exists(database, name);
    };

    /// Returns whether the foreign symbol is a "dynamic constant".
    /// If the symbol hasn't been added then this function returns `false`.
    ///
    /// @param {String} name
    ///   The name of the symbol as it appears in Catspeak.
    ///
    /// @return {Any}
    static isDynamicConstant = function (name) {
        return (databaseDynConst[$ name] ?? false);
    };

    /// Bans an array of symbols from being used by this interface. Any
    /// symbols in this list will be treated as though they do not exist. To
    /// unban a set of symbols, you should use the [addPardonList].
    ///
    /// If a symbol was previously banned, this function will have no effect.
    ///
    /// @param {String} ban
    ///   The symbol to ban the usage of from within __BentoScript.
    static addBanList = function () {
        var banList_ = banList;
        for (var i = 0; i < argument_count; i += 1) {
            var ban = argument[i];
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArg("ban", ban, is_string);
            }
            banList_[$ ban] = true;
        }
    };

    /// Pardons an array of symbols within this interface.
    ///
    /// If a symbol was not previously banned by [addBanList], there will be
    /// no effect.
    ///
    /// @param {String} pardon
    ///   The symbol to pardon the usage of from within __BentoScript.
    static addPardonList = function () {
        var banList_ = banList;
        for (var i = 0; i < argument_count; i += 1) {
            var pardon = argument[i];
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArg("pardon", pardon, is_string);
            }
            if (variable_struct_exists(banList_, pardon)) {
                variable_struct_remove(banList_, pardon);
            }
        }
    };

    /// Exposes a constant value to this interface.
    ///
    /// NOTE: You cannot expose functions using this function. Instead you
    ///       should use one of [exposeDynamicConstant] or [exposeFunction]
    ///       or [exposeMethod].
    ///
    /// @param {String} name
    ///   The name of the constant as it will appear in __BentoScript.
    ///
    /// @param {Any} value
    ///   The constant value to add.
    static exposeConstant = function () {
        for (var i = 0; i < argument_count; i += 2) {
            var name = argument[i + 0];
            var value = argument[i + 1];
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArg("name", name, is_string);
                //__BentoScriptCheckArgNot("value", value, __BentoScriptIsCallable);
            }
            database[$ name] = value;
        }
    };
    
    static exposeNativeConstant = function () {
        for (var i = 0; i < argument_count; i += 2) {
            var name = argument[i + 0];
            var value = argument[i + 1];
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArg("name", name, is_string);
                //__BentoScriptCheckArgNot("value", value, __BentoScriptIsCallable);
            }
            name = string_upper(name);
            database[$ name] = value;
        }
    }

    /// Exposes a "dynamic constant" to this interface. The value provided
    /// for the constant should be a script or method. When the dynamic
    /// constant is evaluated at runtime, the method will be executed with
    /// zero arguments and the return value used as the value of the constant.
    ///
    /// @param {String} name
    ///   The name of the constant as it will appear in Catspeak.
    ///
    /// @param {Function} func
    ///   The script ID or function to add.
    static exposeDynamicConstant = function () {
        for (var i = 0; i < argument_count; i += 2) {
            var name = argument[i + 0];
            var func = argument[i + 1];
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArg("name", name, is_string);
                __BentoScriptCheckArg("func", func, is_method);
            }
            func = is_method(func) ? func : method(undefined, func);
            database[$ name] = func;
            databaseDynConst[$ name] = true;
        }
    };

    /// Exposes a new unbound function to this interface. When passed a bound
    /// method (i.e. a non-global function), it will be unbound before it's
    /// added to the interface.
    ///
    /// If you would prefer to keep the bound `self` of a method, you should
    /// use the [exposeMethod] function instead.
    ///
    /// @param {String} name
    ///   The name of the function as it will appear in __BentoScript.
    ///
    /// @param {Function} func
    ///   The script ID or function to add.
    static exposeFunction = function () {
        for (var i = 0; i < argument_count; i += 2) {
            var name = argument[i + 0];
            var func = argument[i + 1];
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArg("name", name, is_string);
                //__BentoScriptCheckArg("func", func, __BentoScriptIsCallable);
            }
            func = is_method(func) ? method_get_index(func) : func;
            database[$ name] = method(undefined, func);
        }
    };
    
    static exposeUseFunction = function (_name, _openFunc, _closeFunc) {
        exposeMethod(_name, method({
            __open:  method(undefined, _openFunc),
            __close: method(undefined, _closeFunc),
        }, function()
        {
            __open();
            return __close;
        }));
    };
    
    static exposeNativeFunction = function () {
        for (var i = 0; i < argument_count; i += 2) {
            var name = argument[i + 0];
            var func = argument[i + 1];
            
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArg("name", name, is_string);
                //__BentoScriptCheckArg("func", func, __BentoScriptIsCallable);
            }
            
            if (not BENTOSCRIPT_NATIVE_SNAKE_CASE)
            {
                name = string_upper(string_char_at(name, 1)) + string_delete(name, 1, 1);
                
                var _pos = string_pos_ext("_", name, 1);
                while(_pos > 0)
                {
                    var _insert = string_upper(string_char_at(name, _pos+1));
                    name = string_delete(name, _pos, 2);
                    name = string_insert(_insert, name, _pos);
                    _pos = string_pos_ext("_", name, _pos-1);
                }
            }
            
            func = is_method(func) ? method_get_index(func) : func;
            database[$ name] = method(undefined, func);
        }
    }

    /// Behaves similarly to [exposeFunction], except the name of definition
    /// is inferred. There are three ways a name will be inferred:
    ///
    ///  1) If the value is a script resource, `script_get_name` is used.
    ///  2) If the value is a method and a `name` field exists, then the value
    ///     of this `name` field will be used as the name.
    ///  3) If the value is a method and a `name` field does not exist, then
    ///     `script_get_name` will be called on the underlying bound script
    ///     resource.
    ///
    /// @param {Function} func
    ///   The script ID or function to add.
    static exposeFunctionByName = function () {
        for (var i = 0; i < argument_count; i += 1) {
            var func = argument[i];
            if (BENTOSCRIPT_DEBUG_MODE) {
                //__BentoScriptCheckArg("func", func, __BentoScriptIsCallable);
            }
            var name = __BentoScriptInferFunctionName(func);
            func = is_method(func) ? method_get_index(func) : func;
            database[$ name] = method(undefined, func);
        }
    };

    /// Exposes many user-defined global GML functions to this interface which
    /// share a common prefix.
    ///
    /// @param {String} namespace
    ///   The common prefix for the set of functions you want to expose to
    ///   __BentoScript.
    static exposeFunctionByPrefix = function () {
        for (var i = 0; i < argument_count; i += 1) {
            var namespace = argument[i];
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArg("namespace", namespace, is_string);
            }
            // asset scanning for functions can be a lil weird, in my experience
            // i've came across a few variations
            //
            // their positions aren't always 100% known, except for anon
            // (which is always at the front)
            var database_ = database;
            for (var scriptID = 100001; script_exists(scriptID); scriptID += 1) {
                var name = script_get_name(scriptID);
                if (
                    string_starts_with(name, "anon") ||
                    string_count("gml_GlobalScript", name) > 0 ||
                    string_count("__struct__", name) > 0
                ) {
                    continue;
                }
                if (string_starts_with(name, namespace)) {
                    database_[$ name] = method(undefined, scriptID); 
                }
            }
        }
    };

    /// Exposes a new bound function to this interface.
    ///
    /// @param {String} name
    ///   The name of the method as it will appear in __BentoScript.
    ///
    /// @param {Function} func
    ///   The script ID or method to add.
    static exposeMethod = function () {
        for (var i = 0; i < argument_count; i += 2) {
            var name = argument[i + 0];
            var func = argument[i + 1];
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArg("name", name, is_string);
                //__BentoScriptCheckArg("func", func, __BentoScriptIsCallable);
            }
            func = is_method(func) ? func : method(undefined, func);
            database[$ name] = func;
        }
    };

    /// Behaves similarly to [exposeMethod], except the name of definition
    /// is inferred. There are three ways a name will be inferred:
    ///
    ///  1) If the value is a script resource, `script_get_name` is used.
    ///  2) If the value is a method and a `name` field exists, then the value
    ///     of this `name` field will be used as the name.
    ///  3) If the value is a method and a `name` field does not exist, then
    ///     `script_get_name` will be called on the underlying bound script
    ///     resource.
    ///
    /// @param {Function} func
    ///   The script ID or method to add.
    static exposeMethodByName = function () {
        for (var i = 0; i < argument_count; i += 1) {
            var func = argument[i];
            if (BENTOSCRIPT_DEBUG_MODE) {
                //__BentoScriptCheckArg("func", func, __BentoScriptIsCallable);
            }
            var name = __BentoScriptInferFunctionName(func);
            func = is_method(func) ? func : method(undefined, func);
            database[$ name] = func;
        }
    };

    /// Exposes a GameMaker asset from the resource tree to this interface.
    ///
    /// @param {String} name
    ///   The name of the GM asset that you wish to expose to __BentoScript.
    static exposeAsset = function () {
        for (var i = 0; i < argument_count; i += 1) {
            var name = argument[i];
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArg("name", name, is_string);
            }
            var value = asset_get_index(name);
            var type = asset_get_type(name);
            // validate that it's an actual GM Asset
            if (value == -1) {
                __BentoScriptError(
                    "invalid GMAsset: got '", value, "' from '", name, "'"
                );
            }
            if (type == asset_script) {
                // scripts must be coerced into methods
                value = method(undefined, value);
            }
            database[$ name] = value;
        }
    };

    /// Exposes a set of tagged GameMaker assets to this interface.
    ///
    /// @param {Any} tag
    ///   The name of a tag, or array of tags, of assets to expose to __BentoScript.
    static exposeAssetByTag = function () {
        for (var i = 0; i < argument_count; i += 1) {
            var assets = tag_get_assets(argument[i]);
            for (var j = array_length(assets) - 1; j >= 0; j -= 1) {
                exposeAsset(assets[j]);
            }
        }
    };
}

/// The number of microseconds before a BentoScript program times out. The
/// default is 1 second.
#macro BENTOSCRIPT_TIMEOUT 1000

/// @ignore
///
/// @param {Real} t
function __BentoScriptTimeoutCheck(t) {
    gml_pragma("forceinline");
    if (current_time - t > BENTOSCRIPT_TIMEOUT) {
        __BentoScriptError(
            "process exceeded allowed time of ", BENTOSCRIPT_TIMEOUT, " ms"
        );
    }
}

/// Consumes an abstract syntax graph and converts it into a callable GML
/// function.
///
/// NOTE: Do not modify the the syntax graph whilst compilation is taking
///       place. This will cause undefined behaviour, potentially resulting
///       in hard to discover bugs!
///
/// @unstable
///
/// @param {Struct} asg
///   The syntax graph to compile.
///
/// @param {Struct} [interface]
///   The native interface to use.
function __BentoScriptClassGMLCompiler(asg, interface=undefined) constructor {
    if (BENTOSCRIPT_DEBUG_MODE) {
        __BentoScriptCheckInit();
        __BentoScriptCheckArgStruct("asg", asg,
            "functions", is_array,
            "entryPoints", is_array
        );
    }
    self.interface = interface;
    self.functions = asg.functions;
    
    self.sharedData = {
        execScope : asg.environment.globalVars,
        execScopeStack : [],
        globalVars : asg.environment.globalVars,
    };
    
    //# feather disable once GM2043
    self.program = __compileFunctions(asg.entryPoints);
    self.finalised = false;

    /// @ignore
    ///
    /// @param {String} name
    static __get = function (name) {
        if (interface == undefined) {
            return undefined;
        }
        return interface.get(name);
    }

    /// @ignore
    ///
    /// @param {String} name
    static __exists = function (name) {
        if (interface == undefined) {
            return undefined;
        }
        return interface.exists(name);
    }

    /// @ignore
    ///
    /// @param {String} name
    static __isDynamicConstant = function (name) {
        if (interface == undefined) {
            return false;
        }
        return interface.isDynamicConstant(name);
    }

    /// Updates the compiler by generating the code for a single term from the
    /// supplied syntax graph. Returns the result of the compilation if there
    /// are no more terms to compile, or `undefined` if there are still more
    /// terms left to compile.
    ///
    /// @example
    ///   Creates a new [__BentoScriptClassGMLCompiler] from the variable `asg` and
    ///   loops until the compiler is finished compiling. The final result is
    ///   assigned to the `result` local variable.
    ///
    /// ```gml
    /// var compiler = new __BentoScriptClassGMLCompiler(asg);
    /// var result;
    /// do {
    ///     result = compiler.update();
    /// } until (result != undefined);
    /// ```
    ///
    /// @return {Function}
    static update = function () {
        if (BENTOSCRIPT_DEBUG_MODE && finalised) {
            __BentoScriptError(
                "attempting to update gml compiler after it has been finalised"
            );
        }
        finalised = true;
        return program;
    };

    /// @ignore
    ///
    /// @param {Array} entryPoints
    /// @return {Function}
    static __compileFunctions = function (entryPoints) {
        var functions_ = functions;
        var entryCount = array_length(entryPoints);
        var exprs = array_create(entryCount);
        for (var i = 0; i < entryCount; i += 1) {
            var entry = entryPoints[i];
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArg("entry", entry, is_numeric);
            }
            exprs[@ i] = __compileFunction(functions_[entry]);
        }
        var rootCall = __emitBlock(exprs);
        __setup__BentoScriptFunctionMethods(rootCall);
        return rootCall;
    };

    static __setup__BentoScriptFunctionMethods = function (f) {
        
        f.pushExecScope = method(sharedData, function (globalInst) {
            array_push(execScopeStack, globalInst);
            execScope = bentoScript_special_to_struct(globalInst);
        });
        f.popExecScope = method(sharedData, function () {
            if (array_length(execScopeStack) > 0) array_pop(execScopeStack);
            
            if (array_length(execScopeStack) <= 0) {
                execScope = globalVars;
            } else {
                execScope = bentoScript_special_to_struct(execScopeStack[array_length(execScopeStack)-1]);
            }
        });
        f.setExecScope = method(sharedData, function (globalInst) {
            execScope = bentoScript_special_to_struct(globalInst);
            execScopeStack = [execScope];
        });
        f.resetExecScope = method(sharedData, function() {
            execScope = globalVars;
        });
        f.getExecScope = method(sharedData, function () { return execScope });
        f.getGlobalVars = method(sharedData, function () {
            return globalVars;
        });
    };

    /// @ignore
    ///
    /// @param {Struct} func
    /// @return {Function}
    static __compileFunction = function (func) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("func", func,
                "localCount", is_numeric,
                "argCount", is_numeric,
                "root", undefined
            );
            __BentoScriptCheckArgStruct("func.root", func.root,
                "type", is_numeric
            );
        }
        var ctx = {
            callTime : -1,
            program : undefined,
            locals : array_create(func.localCount),
            argCount : func.argCount,
        };
        ctx.program = __compileTerm(ctx, func.root);
        if (__BentoScriptTermIsPure(func.root.type)) {
            // if there's absolutely no way this function could misbehave,
            // use the fast path
            return ctx.program;
        }
        var _method = method(ctx, __BentoScriptFunction__);
        ctx.boundFunc = _method;
        return _method;
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileValue = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "value", undefined
            );
        }
        return method({ value : term.value }, __BentoScriptExprValue__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileArray = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "values", is_array
            );
        }
        var values = term.values;
        var valueCount = array_length(values);
        var exprs = array_create(valueCount);
        for (var i = 0; i < valueCount; i += 1) {
            exprs[@ i] = __compileTerm(ctx, values[i]);
        }
        return method({
            values : exprs,
            n : array_length(exprs),
        }, __BentoScriptExprArray__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileStruct = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "values", is_array
            );
        }
        var values = term.values;
        var valueCount = array_length(values);
        var exprs = array_create(valueCount);
        for (var i = 0; i < valueCount; i += 1) {
            exprs[@ i] = __compileTerm(ctx, values[i]);
        }
        return method({
            values : exprs,
            n : array_length(exprs) div 2,
        }, __BentoScriptExprStruct__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileBlock = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "terms", is_array
            );
        }
        var terms = term.terms;
        var termCount = array_length(terms);
        var exprs = array_create(termCount);
        for (var i = 0; i < termCount; i += 1) {
            exprs[@ i] = __compileTerm(ctx, terms[i]);
        }
        return __emitBlock(exprs);
    };

    /// @ignore
    ///
    /// @param {Array} exprs
    /// @return {Function}
    static __emitBlock = function (exprs) {
        var exprCount = array_length(exprs);
        // hard-code some common block sizes
        if (exprCount == 1) {
            return exprs[0];
        } else if (exprCount == 2) {
            return method({
                _1st : exprs[0],
                _2nd : exprs[1],
            }, __BentoScriptExprBlock2__);
        } else if (exprCount == 3) {
            return method({
                _1st : exprs[0],
                _2nd : exprs[1],
                _3rd : exprs[2],
            }, __BentoScriptExprBlock3__);
        } else if (exprCount == 4) {
            return method({
                _1st : exprs[0],
                _2nd : exprs[1],
                _3rd : exprs[2],
                _4th : exprs[3],
            }, __BentoScriptExprBlock4__);
        } else if (exprCount == 5) {
            return method({
                _1st : exprs[0],
                _2nd : exprs[1],
                _3rd : exprs[2],
                _4th : exprs[3],
                _5th : exprs[4],
            }, __BentoScriptExprBlock5__);
        }
        // arbitrary size block
        return method({
            stmts : exprs,
            n : exprCount - 1,
            result : exprs[exprCount - 1],
        }, __BentoScriptExprBlock__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileIf = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "condition", undefined,
                "ifTrue", undefined,
                "ifFalse", undefined
            );
        }
        if (term.ifFalse == undefined) {
            return method({
                condition : __compileTerm(ctx, term.condition),
                ifTrue : __compileTerm(ctx, term.ifTrue),
            }, __BentoScriptExprIf__);
        } else {
            return method({
                condition : __compileTerm(ctx, term.condition),
                ifTrue : __compileTerm(ctx, term.ifTrue),
                ifFalse : __compileTerm(ctx, term.ifFalse),
            }, __BentoScriptExprIfElse__);
        }
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileWhile = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "condition", undefined,
                "body", undefined
            );
        }
        return method({
            ctx : ctx,
            condition : __compileTerm(ctx, term.condition),
            body : __compileTerm(ctx, term.body),
        }, __BentoScriptExprWhile__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileBuild = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "condition", undefined,
                "body", undefined
            );
        }
        return method({
            dbgError : __dbgTerm(term.condition, "is not a function"),
            condition : __compileTerm(ctx, term.condition),
            body : __compileTerm(ctx, term.body),
        }, __BentoScriptExprBuild__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileUse = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "condition", undefined,
                "body", undefined
            );
        }
        return method({
            dbgError : __dbgTerm(term.condition, "is not a function"),
            condition : __compileTerm(ctx, term.condition),
            body : __compileTerm(ctx, term.body),
        }, __BentoScriptExprUse__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileReturn = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "value", undefined
            );
        }
        return method({
            value : __compileTerm(ctx, term.value),
        }, __BentoScriptExprReturn__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileBreak = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "value", undefined
            );
        }
        return method({
            value : __compileTerm(ctx, term.value),
        }, __BentoScriptExprBreak__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileContinue = function (ctx, term) {
        return method(undefined, __BentoScriptExprContinue__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileOpUnary = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "operator", is_numeric, // TODO :: add proper bounds check here
                "value", undefined
            );
        }
        return method({
            op : __BentoScript_operator_get_unary(term.operator),
            value : __compileTerm(ctx, term.value),
        }, __BentoScriptExprOp1__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileOpBinary = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "operator", is_numeric, // TODO :: add proper bounds check here
                "lhs", undefined,
                "rhs", undefined
            );
        }
        return method({
            op : __BentoScript_operator_get_binary(term.operator),
            lhs : __compileTerm(ctx, term.lhs),
            rhs : __compileTerm(ctx, term.rhs),
        }, __BentoScriptExprOp2__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileAnd = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "eager", undefined,
                "lazy", undefined
            );
        }
        return method({
            eager : __compileTerm(ctx, term.eager),
            lazy : __compileTerm(ctx, term.lazy),
        }, __BentoScriptExprAnd__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileOr = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "eager", undefined,
                "lazy", undefined
            );
        }
        return method({
            eager : __compileTerm(ctx, term.eager),
            lazy : __compileTerm(ctx, term.lazy),
        }, __BentoScriptExprOr__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileCall = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "callee", undefined,
                "args", undefined
            );
            __BentoScriptCheckArgStruct("term.callee", term.callee,
                "type", is_numeric
            );
        }
        var args = term.args;
        var argCount = array_length(args);
        var exprs = array_create(argCount);
        for (var i = 0; i < argCount; i += 1) {
            exprs[@ i] = __compileTerm(ctx, args[i]);
        }
        if (term.callee.type == __BENTOSCRIPT_TERM.INDEX) {
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArgStruct("term.callee", term.callee,
                    "collection", undefined,
                    "key", undefined
                );
            }
            var collection = __compileTerm(ctx, term.callee.collection);
            var key = __compileTerm(ctx, term.callee.key);
            return method({
                dbgError : __dbgTerm(term.callee, "is not a function"),
                collection : collection,
                key : key,
                args : exprs,
                shared : sharedData,
            }, __BentoScriptExprCallMethod__);
        } else {
            var callee = __compileTerm(ctx, term.callee);
            return method({
                dbgError : __dbgTerm(term.callee, "is not a function"),
                callee : callee,
                args : exprs,
                shared : sharedData,
            }, __BentoScriptExprCall__);
        }
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileSet = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "assignType", is_numeric,
                "target", undefined,
                "value", undefined,
            );
            __BentoScriptCheckArgStruct("term.target", term.target,
                "type", is_numeric
            );
        }
        var target = term.target;
        var targetType = target.type;
        var value = __compileTerm(ctx, term.value);
        if (targetType == __BENTOSCRIPT_TERM.INDEX) {
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArgStruct("term.target", target,
                    "collection", undefined,
                    "key", undefined
                );
            }
            var func = __assignLookupIndex[term.assignType];
            return method({
                dbgError : __dbgTerm(target.collection, "is not indexable"),
                collection : __compileTerm(ctx, target.collection),
                key : __compileTerm(ctx, target.key),
                value : value,
            }, func);
        } else if (targetType == __BENTOSCRIPT_TERM.LOCAL) {
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArgStruct("term.target", target,
                    "idx", is_numeric
                );
            }
            var func = __assignLookupLocal[term.assignType];
            return method({
                locals : ctx.locals,
                idx : target.idx,
                value : value,
            }, func);
        } else if (targetType == __BENTOSCRIPT_TERM.NAKED) {
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArgStruct("term.target", target,
                    "name", is_string
                );
            }
            var name = target.name;
            if (__exists(name)) {
                // cannot assign to interface values
                __BentoScriptError(
                    __BentoScriptLocationShow(target.dbg),
                    " -- invalid assignment target, ",
                    "cannot assign to built-in function or constant"
                );
            }

            var func = __assignLookupGlobal[term.assignType];
            return method({
                shared : sharedData,
                name : name,
                value : value,
            }, func);
        } else {
            if (BENTOSCRIPT_DEBUG_MODE) {
                __BentoScriptCheckArgStruct("term.target", target,
                    "dbg", undefined
                );
            }
            __BentoScriptError(
                __BentoScriptLocationShow(target.dbg),
                " -- invalid assignment target, ",
                "must be an identifier or accessor expression"
            );
        }
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileIndex = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "collection", undefined,
                "key", undefined
            );
        }
        return method({
            dbgError : __dbgTerm(term.collection, "is not indexable"),
            collection : __compileTerm(ctx, term.collection),
            key : __compileTerm(ctx, term.key),
        }, __BentoScriptExprIndexGet__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileGlobal = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "name", is_string
            );
        }
        var name = term.name;
        if (__exists(name)) {
            var _callee = method({
                value : __get(name),
            }, __BentoScriptExprValue__);
            if (__isDynamicConstant(name)) {
                // dynamic constant
                return method({
                    dbgError : __dbgTerm(term, "is not a function"),
                    callee : _callee,
                    args : [],
                    shared : sharedData,
                }, __BentoScriptExprCall__);
            } else {
                // user-defined interface
                return _callee;
            }
        } else {
            // global var
            return method({
                name : name,
                shared : sharedData,
            }, __BentoScriptExprScopeGet__);
        }
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileLocal = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "idx", is_numeric
            );
        }
        return method({
            locals : ctx.locals,
            idx : term.idx,
        }, __BentoScriptExprLocalGet__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileFunctionExpr = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "idx", is_numeric
            );
        }
        var funcExpr = __compileFunction(functions[term.idx]);
        __setup__BentoScriptFunctionMethods(funcExpr);
        return method({
            value : funcExpr,
        }, __BentoScriptExprValue__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileSelf = function (ctx, term) {
        return method(sharedData, __BentoScriptExprSelf__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileTerm = function (ctx, term) {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "type", is_numeric
            );
        }
        var prod = __productionLookup[term.type];
        if (BENTOSCRIPT_DEBUG_MODE && prod == undefined) {
            __BentoScriptErrorBug();
        }
        return prod(ctx, term);
    };

    /// @ignore
    static __productionLookup = (function () {
        var db = array_create(__BENTOSCRIPT_TERM.__SIZE__, undefined);
        db[@ __BENTOSCRIPT_TERM.VALUE] = __compileValue;
        db[@ __BENTOSCRIPT_TERM.ARRAY] = __compileArray;
        db[@ __BENTOSCRIPT_TERM.STRUCT] = __compileStruct;
        db[@ __BENTOSCRIPT_TERM.BLOCK] = __compileBlock;
        db[@ __BENTOSCRIPT_TERM.IF] = __compileIf;
        db[@ __BENTOSCRIPT_TERM.WHILE] = __compileWhile;
        db[@ __BENTOSCRIPT_TERM.BUILD] = __compileBuild;
        db[@ __BENTOSCRIPT_TERM.USE] = __compileUse;
        db[@ __BENTOSCRIPT_TERM.RETURN] = __compileReturn;
        db[@ __BENTOSCRIPT_TERM.BREAK] = __compileBreak;
        db[@ __BENTOSCRIPT_TERM.CONTINUE] = __compileContinue;
        db[@ __BENTOSCRIPT_TERM.OP_BINARY] = __compileOpBinary;
        db[@ __BENTOSCRIPT_TERM.OP_UNARY] = __compileOpUnary;
        db[@ __BENTOSCRIPT_TERM.CALL] = __compileCall;
        db[@ __BENTOSCRIPT_TERM.SET] = __compileSet;
        db[@ __BENTOSCRIPT_TERM.INDEX] = __compileIndex;
        db[@ __BENTOSCRIPT_TERM.NAKED] = __compileGlobal;
        db[@ __BENTOSCRIPT_TERM.LOCAL] = __compileLocal;
        db[@ __BENTOSCRIPT_TERM.FUNCTION] = __compileFunctionExpr;
        db[@ __BENTOSCRIPT_TERM.SELF] = __compileSelf;
        db[@ __BENTOSCRIPT_TERM.AND] = __compileAnd;
        db[@ __BENTOSCRIPT_TERM.OR] = __compileOr;
        return db;
    })();

    /// @ignore
    static __assignLookupIndex = (function () {
        var db = array_create(__BENTOSCRIPT_ASSIGN.__SIZE__, undefined);
        db[@ __BENTOSCRIPT_ASSIGN.VANILLA] = __BentoScriptExprIndexSet__;
        db[@ __BENTOSCRIPT_ASSIGN.MULTIPLY] = __BentoScriptExprIndexSetMult__;
        db[@ __BENTOSCRIPT_ASSIGN.DIVIDE] = __BentoScriptExprIndexSetDiv__;
        db[@ __BENTOSCRIPT_ASSIGN.SUBTRACT] = __BentoScriptExprIndexSetSub__;
        db[@ __BENTOSCRIPT_ASSIGN.PLUS] = __BentoScriptExprIndexSetPlus__;
        return db;
    })();

    /// @ignore
    static __assignLookupLocal = (function () {
        var db = array_create(__BENTOSCRIPT_ASSIGN.__SIZE__, undefined);
        db[@ __BENTOSCRIPT_ASSIGN.VANILLA] = __BentoScriptExprLocalSet__;
        db[@ __BENTOSCRIPT_ASSIGN.MULTIPLY] = __BentoScriptExprLocalSetMult__;
        db[@ __BENTOSCRIPT_ASSIGN.DIVIDE] = __BentoScriptExprLocalSetDiv__;
        db[@ __BENTOSCRIPT_ASSIGN.SUBTRACT] = __BentoScriptExprLocalSetSub__;
        db[@ __BENTOSCRIPT_ASSIGN.PLUS] = __BentoScriptExprLocalSetPlus__;
        return db;
    })();

    /// @ignore
    static __assignLookupGlobal = (function () {
        var db = array_create(__BENTOSCRIPT_ASSIGN.__SIZE__, undefined);
        db[@ __BENTOSCRIPT_ASSIGN.VANILLA] = __BentoScriptExprScopeSet__;
        db[@ __BENTOSCRIPT_ASSIGN.MULTIPLY] = __BentoScriptExprScopeSetMult__;
        db[@ __BENTOSCRIPT_ASSIGN.DIVIDE] = __BentoScriptExprScopeSetDiv__;
        db[@ __BENTOSCRIPT_ASSIGN.SUBTRACT] = __BentoScriptExprScopeSetSub__;
        db[@ __BENTOSCRIPT_ASSIGN.PLUS] = __BentoScriptExprScopeSetPlus__;
        return db;
    })();

    /// @ignore
    static __dbgTerm = function (term, msg="is invalid in this context") {
        if (BENTOSCRIPT_DEBUG_MODE) {
            __BentoScriptCheckArgStruct("term", term,
                "dbg", undefined
            );
        }
        var terminalName = __BentoScriptTermGetTerminal(term);
        return "runtime error " + __BentoScriptLocationShowExt(term.dbg,
            terminalName == undefined
                    ? "value"
                    : "variable '" + terminalName + "'",
            " ", msg
        );
    };
}

/// @ignore
/// @return {Any}
function __BentoScriptFunction__() {
    static _global = __BentoScriptGMLGlobal();
    var _oldFunction = _global.__bentoScriptCurrentFunction;
    _global.__bentoScriptCurrentFunction = boundFunc;
    
    var isRecursing = callTime >= 0;
    if (isRecursing) {
        // catch unbound recursion
        __BentoScriptTimeoutCheck(callTime);
        // store the previous local variable array
        // this will make function recursion quite expensive, but
        // hopefully that's uncommon enough for it to not matter
        var localCount = array_length(locals);
        var oldLocals = array_create(localCount);
        array_copy(oldLocals, 0, locals, 0, localCount);
    } else {
        callTime = current_time;
    }
    for (var argI = argCount - 1; argI >= 0; argI -= 1) {
        locals[@ argI] = argument[argI];
    }
    var value;
    try {
        value = program();
    } catch (e) {
        if (e == _global.__bentoScriptGmlReturnRef) {
            value = e[0];
        } else {
            throw e;
        }
    } finally {
        if (isRecursing) {
            // bad practice to use `localCount_` here, but it saves
            // a tiny bit of time so I'll be a bit evil
            //# feather disable once GM2043
            array_copy(locals, 0, oldLocals, 0, localCount);
        } else {
            // reset the timer
            callTime = -1;
        }
    }
    
    _global.__bentoScriptCurrentFunction = _oldFunction;
    return value;
}

/// @ignore
/// @return {Any}
function __BentoScriptExprValue__() {
    return value;
}

/// @ignore
/// @return {Any}
function __BentoScriptExprArray__() {
	//return array_map(values, function(f) { return f() });
	var i = 0;
    var values_ = values;
    var n_ = n;
	var arr = array_create(n_);
    repeat (n_) {
        // not sure if this is even fast
        // but people will cry if I don't do it
        var value = values_[i];
        arr[@ i] = value();
        i += 1;
    }
    return arr;
}

/// @ignore
/// @return {Any}
function __BentoScriptExprStruct__() {
    var obj = { };
    var i = 0;
    var values_ = values;
    var n_ = n;
    repeat (n_) {
        // not sure if this is even fast
        // but people will cry if I don't do it
        var key = values_[i + 0];
        var value = values_[i + 1];
        obj[$ key()] = value();
        i += 2;
    }
    return obj;
}

/// @ignore
/// @return {Any}
function __BentoScriptExprBlock__() {
    //array_foreach(stmts, function (stmt) { stmt() });
    var i = 0;
    var stmts_ = stmts;
    var n_ = n;
    repeat (n_) {
        // not sure if this is even fast
        // but people will cry if I don't do it
        var expr = stmts_[i];
        expr();
        i += 1;
    }
    return result();
}

/// @ignore
/// @return {Any}
function __BentoScriptExprBlock2__() {
    _1st();
    return _2nd();
}

/// @ignore
/// @return {Any}
function __BentoScriptExprBlock3__() {
    _1st();
    _2nd();
    return _3rd();
}

/// @ignore
/// @return {Any}
function __BentoScriptExprBlock4__() {
    _1st();
    _2nd();
    _3rd();
    return _4th();
}

/// @ignore
/// @return {Any}
function __BentoScriptExprBlock5__() {
    _1st();
    _2nd();
    _3rd();
    _4th();
    return _5th();
}

/// @ignore
/// @return {Any}
function __BentoScriptExprIf__() {
    return condition() ? ifTrue() : undefined;
}

/// @ignore
/// @return {Any}
function __BentoScriptExprIfElse__() {
    return condition() ? ifTrue() : ifFalse();
}

/// @ignore
/// @return {Any}
function __BentoScriptExprAnd__() {
    return eager() && lazy();
}

/// @ignore
/// @return {Any}
function __BentoScriptExprOr__() {
    return eager() || lazy();
}

/// @ignore
/// @return {Any}
function __BentoScriptExprWhile__() {
    static _global = __BentoScriptGMLGlobal();
    var callTime = ctx.callTime;
    var condition_ = condition;
    var body_ = body;
    while (condition_()) {
        __BentoScriptTimeoutCheck(callTime);
        try {
            body_();
        } catch (e) {
            if (e == _global.__bentoScriptGmlBreakRef) {
                return e[0];
            } else if (e != _global.__bentoScriptGmlContinueRef) {
                throw e;
            }
        }
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprBuild__() {
    var body_ = body;
    var open = condition();
    if (!is_method(open)) {
        __BentoScriptErrorGot(dbgError, open);
    }
    var close = open();
    if (!is_method(close)) {
        __BentoScriptErrorGot(dbgError, close);
    }
    var result;
    try {
        body_();
    } finally {
        result = close();
    }
    return result;
}

/// @ignore
/// @return {Any}
function __BentoScriptExprUse__() {
    var body_ = body;
    var open = condition();
    if (!is_method(open)) {
        __BentoScriptErrorGot(dbgError, open);
    }
    var close = open();
    if (!is_method(close)) {
        __BentoScriptErrorGot(dbgError, close);
    }
    var result;
    try {
        body_();
    } finally {
        result = close();
    }
    return result;
}

/// @ignore
/// @return {Any}
function __BentoScriptExprWhileSimple__() {
    var callTime = ctx.callTime;
    var condition_ = condition;
    var body_ = body;
    while (condition_()) {
        __BentoScriptTimeoutCheck(callTime);
        body_();
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprReturn__() {
    static _global = __BentoScriptGMLGlobal();
    var box = _global.__bentoScriptGmlReturnRef;
    box[@ 0] = value();
    throw box;
}

/// @ignore
/// @return {Any}
function __BentoScriptExprBreak__() {
    static _global = __BentoScriptGMLGlobal();
    var box = _global.__bentoScriptGmlBreakRef;
    box[@ 0] = value();
    throw box;
}

/// @ignore
/// @return {Any}
function __BentoScriptExprContinue__() {
    static _global = __BentoScriptGMLGlobal();
    throw _global.__bentoScriptGmlContinueRef;
}

/// @ignore
/// @return {Any}
function __BentoScriptExprOp1__() {
    var value_ = value();
    return op(value_);
}

/// @ignore
/// @return {Any}
function __BentoScriptExprOp2__() {
    var lhs_ = lhs();
    var rhs_ = rhs();
    return op(lhs_, rhs_);
}

/// @ignore
/// @return {Any}
function __BentoScriptExprCallMethod__() {
    // TODO :: this method call stuff is crap, please figure out a better way
    var collection_ = collection();
    var key_ = key();
    var callee_;
    if (is_array(collection_)) {
        callee_ = collection_[key_];
    } else if (__BentoScriptIsWithable(collection_)) {
        callee_ = collection_[$ key_];
    } else {
        // TODO :: bad error message
        __BentoScriptErrorGot(dbgError, collection_);
    }
    if (!is_method(callee_)) {
        __BentoScriptErrorGot(dbgError, callee_);
    }
    var args_;
    { //var args_ = array_map(args, function(f) { return f() });
        var i = 0;
        var values_ = args;
        var n_ = array_length(values_);
        args_ = array_create(n_);
        repeat (n_) {
            // not sure if this is even fast
            // but people will cry if I don't do it
            var value = values_[i];
            args_[@ i] = value();
            i += 1;
        }
    }
    var shared_ = shared;
    with (method_get_self(callee_) ?? collection_) {
        var calleeIdx = method_get_index(callee_);
        return script_execute_ext(calleeIdx, args_);
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprCall__() {
    var callee_ = callee();
    if (!is_method(callee_)) {
        __BentoScriptErrorGot(dbgError, callee_);
    }
    var args_;
    { //var args_ = array_map(args, function(f) { return f() });
        var i = 0;
        var values_ = args;
        var n_ = array_length(values_);
        args_ = array_create(n_);
        repeat (n_) {
            // not sure if this is even fast
            // but people will cry if I don't do it
            var value = values_[i];
            args_[@ i] = value();
            i += 1;
        }
    }
    var shared_ = shared;
    with (method_get_self(callee_) ?? shared_.execScope) {
        var calleeIdx = method_get_index(callee_);
        return script_execute_ext(calleeIdx, args_);
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprIndexGet__() {
    var collection_ = collection();
    var key_ = key();
    if (is_array(collection_)) {
        return collection_[key_];
    } else if (is_struct(collection_)) {
        if (variable_struct_exists(collection_, BENTOSCRIPT_GETTER_NAME)) {
            return collection_.BENTOSCRIPT_GETTER(key_);
        } else {
            return collection_[$ key_];
        }
    } else {
        __BentoScriptErrorGot(dbgError, collection_);
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprIndexSet__() {
    var collection_ = collection();
    var key_ = key();
    var value_ = value();
    if (is_array(collection_)) {
        collection_[@ key_] = value_;
    } else if (is_struct(collection_)) {
        if (variable_struct_exists(collection_, BENTOSCRIPT_SETTER_NAME)) {
            collection_.BENTOSCRIPT_SETTER(key_, value_);
        } else {
            collection_[$ key_] = value_;
        }
    } else {
        __BentoScriptErrorGot(dbgError, collection_);
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprIndexSetMult__() {
    var collection_ = collection();
    var key_ = key();
    var value_ = value();
    if (is_array(collection_)) {
        collection_[@ key_] *= value_;
    } else if (is_struct(collection_)) {
        if (variable_struct_exists(collection_, BENTOSCRIPT_GETTER_NAME)) {
            if (variable_struct_exists(collection_, BENTOSCRIPT_SETTER_NAME)) {
                //Getter + setter
                collection_.BENTOSCRIPT_SETTER(key_, collection_.BENTOSCRIPT_GETTER(key_) * value_);
            } else {
                //Only a getter
                collection_[$ key_] = collection_.BENTOSCRIPT_GETTER(key_) * value_;
            }
        } else if (variable_struct_exists(collection_, BENTOSCRIPT_SETTER_NAME)) {
            //Only a setter
            collection_.BENTOSCRIPT_SETTER(key_, collection_[$ key_] * value_);
        } else {
            //No getter or setter
            collection_[$ key_] *= value_;
        }
    } else {
        __BentoScriptErrorGot(dbgError, collection_);
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprIndexSetDiv__() {
    var collection_ = collection();
    var key_ = key();
    var value_ = value();
    if (is_array(collection_)) {
        collection_[@ key_] /= value_;
    } else if (is_struct(collection_)) {
        if (variable_struct_exists(collection_, BENTOSCRIPT_GETTER_NAME)) {
            if (variable_struct_exists(collection_, BENTOSCRIPT_SETTER_NAME)) {
                //Getter + setter
                collection_.BENTOSCRIPT_SETTER(key_, collection_.BENTOSCRIPT_GETTER(key_) / value_);
            } else {
                //Only a getter
                collection_[$ key_] = collection_.BENTOSCRIPT_GETTER(key_) / value_;
            }
        } else if (variable_struct_exists(collection_, BENTOSCRIPT_SETTER_NAME)) {
            //Only a setter
            collection_.BENTOSCRIPT_SETTER(key_, collection_[$ key_] / value_);
        } else {
            //No getter or setter
            collection_[$ key_] /= value_;
        }
    } else {
        __BentoScriptErrorGot(dbgError, collection_);
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprIndexSetSub__() {
    var collection_ = collection();
    var key_ = key();
    var value_ = value();
    if (is_array(collection_)) {
        collection_[@ key_] -= value_;
    } else if (is_struct(collection_)) {
        if (variable_struct_exists(collection_, BENTOSCRIPT_GETTER_NAME)) {
            if (variable_struct_exists(collection_, BENTOSCRIPT_SETTER_NAME)) {
                //Getter + setter
                collection_.BENTOSCRIPT_SETTER(key_, collection_.BENTOSCRIPT_GETTER(key_) - value_);
            } else {
                //Only a getter
                collection_[$ key_] = collection_.BENTOSCRIPT_GETTER(key_) - value_;
            }
        } else if (variable_struct_exists(collection_, BENTOSCRIPT_SETTER_NAME)) {
            //Only a setter
            collection_.BENTOSCRIPT_SETTER(key_, collection_[$ key_] - value_);
        } else {
            //No getter or setter
            collection_[$ key_] -= value_;
        }
    } else {
        __BentoScriptErrorGot(dbgError, collection_);
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprIndexSetPlus__() {
    var collection_ = collection();
    var key_ = key();
    var value_ = value();
    if (is_array(collection_)) {
        collection_[@ key_] += value_;
    } else if (is_struct(collection_)) {
        if (variable_struct_exists(collection_, BENTOSCRIPT_GETTER_NAME)) {
            if (variable_struct_exists(collection_, BENTOSCRIPT_SETTER_NAME)) {
                //Getter + setter
                collection_.BENTOSCRIPT_SETTER(key_, collection_.BENTOSCRIPT_GETTER(key_) + value_);
            } else {
                //Only a getter
                collection_[$ key_] = collection_.BENTOSCRIPT_GETTER(key_) + value_;
            }
        } else if (variable_struct_exists(collection_, BENTOSCRIPT_SETTER_NAME)) {
            //Only a setter
            collection_.BENTOSCRIPT_SETTER(key_, collection_[$ key_] + value_);
        } else {
            //No getter or setter
            collection_[$ key_] += value_;
        }
    } else {
        __BentoScriptErrorGot(dbgError, collection_);
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprScopeGet__() {
    var target = shared.execScope;
    if (variable_struct_exists(target, BENTOSCRIPT_GETTER_NAME)) {
        return target.BENTOSCRIPT_GETTER(name);
    } else {
        return target[$ name];
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprScopeSet__() {
    var target = shared.execScope;
    if (variable_struct_exists(target, BENTOSCRIPT_SETTER_NAME)) {
        target.BENTOSCRIPT_SETTER(name, value());
    } else {
        target[$ name] = value();
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprScopeSetMult__() {
    var target = shared.execScope;
    if (variable_struct_exists(target, BENTOSCRIPT_GETTER_NAME)) {
        if (variable_struct_exists(target, BENTOSCRIPT_SETTER_NAME)) {
            //Getter + setter
            target.BENTOSCRIPT_SETTER(name, target.BENTOSCRIPT_GETTER(name) * value());
        } else {
            //Only a getter
            target[$ name] = target.BENTOSCRIPT_GETTER(name) * value();
        }
    } else if (variable_struct_exists(target, BENTOSCRIPT_SETTER_NAME)) {
        //Only a setter
        target.BENTOSCRIPT_SETTER(name, target[$ name] * value());
    } else {
        //No getter or setter
        target[$ name] *= value();
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprScopeSetDiv__() {
    var target = shared.execScope;
    if (variable_struct_exists(target, BENTOSCRIPT_GETTER_NAME)) {
        if (variable_struct_exists(target, BENTOSCRIPT_SETTER_NAME)) {
            //Getter + setter
            target.BENTOSCRIPT_SETTER(name, target.BENTOSCRIPT_GETTER(name) / value());
        } else {
            //Only a getter
            target[$ name] = target.BENTOSCRIPT_GETTER(name) / value();
        }
    } else if (variable_struct_exists(target, BENTOSCRIPT_SETTER_NAME)) {
        //Only a setter
        target.BENTOSCRIPT_SETTER(name, target[$ name] / value());
    } else {
        //No getter or setter
        target[$ name] /= value();
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprScopeSetSub__() {
    var target = shared.execScope;
    if (variable_struct_exists(target, BENTOSCRIPT_GETTER_NAME)) {
        if (variable_struct_exists(target, BENTOSCRIPT_SETTER_NAME)) {
            //Getter + setter
            target.BENTOSCRIPT_SETTER(name, target.BENTOSCRIPT_GETTER(name) - value());
        } else {
            //Only a getter
            target[$ name] = target.BENTOSCRIPT_GETTER(name) - value();
        }
    } else if (variable_struct_exists(target, BENTOSCRIPT_SETTER_NAME)) {
        //Only a setter
        target.BENTOSCRIPT_SETTER(name, target[$ name] - value());
    } else {
        //No getter or setter
        target[$ name] -= value();
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprScopeSetPlus__() {
    var target = shared.execScope;
    if (variable_struct_exists(target, BENTOSCRIPT_GETTER_NAME)) {
        if (variable_struct_exists(target, BENTOSCRIPT_SETTER_NAME)) {
            //Getter + setter
            target.BENTOSCRIPT_SETTER(name, target.BENTOSCRIPT_GETTER(name) + value());
        } else {
            //Only a getter
            target[$ name] = target.BENTOSCRIPT_GETTER(name) + value();
        }
    } else if (variable_struct_exists(target, BENTOSCRIPT_SETTER_NAME)) {
        //Only a setter
        target.BENTOSCRIPT_SETTER(name, target[$ name] + value());
    } else {
        //No getter or setter
        target[$ name] += value();
    }
}

/// @ignore
/// @return {Any}
function __BentoScriptExprLocalGet__() {
    return locals[idx];
}

/// @ignore
/// @return {Any}
function __BentoScriptExprLocalSet__() {
    locals[@ idx] = value();
}

/// @ignore
/// @return {Any}
function __BentoScriptExprLocalSetMult__() {
    locals[@ idx] *= value();
}

/// @ignore
/// @return {Any}
function __BentoScriptExprLocalSetDiv__() {
    locals[@ idx] /= value();
}

/// @ignore
/// @return {Any}
function __BentoScriptExprLocalSetSub__() {
    locals[@ idx] -= value();
}

/// @ignore
/// @return {Any}
function __BentoScriptExprLocalSetPlus__() {
    locals[@ idx] += value();
}

/// @ignore
/// @return {Any}
function __BentoScriptExprSelf__() {
    return execScope;
}

/// @ignore
function __BentoScriptInitCodegen() {
    static _global = __BentoScriptGMLGlobal();
    /// @ignore
    _global.__bentoScriptGmlReturnRef = [undefined];
    /// @ignore
    _global.__bentoScriptGmlBreakRef = [undefined];
    /// @ignore
    _global.__bentoScriptGmlContinueRef = [];
    /// @ignore
    _global.__bentoScriptCurrentFunction = undefined;
}