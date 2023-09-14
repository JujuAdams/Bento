function __BentoScriptGetGlobalVars()
{
    static _global = __BentoScriptGMLGlobal();
    if (_global.__bentoScriptCurrentFunction == undefined) __BentoScriptError("__BentoScriptGetGlobalVars() must only be called whilst a function is executing");
    _global.__bentoScriptCurrentFunction.getGlobalVars();
}