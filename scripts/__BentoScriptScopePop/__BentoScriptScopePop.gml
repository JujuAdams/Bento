function __BentoScriptScopePop()
{
    static _global = __BentoScriptGMLGlobal();
    
    if (_global.__bentoScriptCurrentFunction != undefined)
    {
        _global.__bentoScriptCurrentFunction.popExecScope();
    }
}