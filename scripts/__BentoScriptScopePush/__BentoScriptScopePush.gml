function __BentoScriptScopePush(_target)
{
    static _global = __BentoScriptGMLGlobal();
    
    if (_global.__bentoScriptCurrentFunction != undefined)
    {
        _global.__bentoScriptCurrentFunction.pushExecScope(_target);
    }
}