function __BentoScriptScope()
{
    static _global = __BentoScriptGMLGlobal();
    
    if (_global.__bentoScriptCurrentFunction != undefined)
    {
        return _global.__bentoScriptCurrentFunction.getExecScope();
    }
}