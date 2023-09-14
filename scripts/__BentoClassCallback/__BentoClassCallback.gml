function __BentoClassCallback(_parent, _function, _fromBentoScript) constructor
{
    static _global = __BentoGlobal();
    
    __parent       = _parent;
    __function     = _function;
    __fromBentoScript = _fromBentoScript;
    
    static __Call = function(_scope, _param0, _param1)
    {
        if (__function == undefined) return;
        
        var _oldCallback       = _global.__currentCallback;
        var _oldCallbackScope  = _global.__currentCallbackScope;
        var _oldCallbackParam0 = _global.__currentCallbackParam0;
        var _oldCallbackParam1 = _global.__currentCallbackParam1;
        
        _global.__currentCallback       = self;
        _global.__currentCallbackScope  = _scope;
        _global.__currentCallbackParam0 = _param0;
        _global.__currentCallbackParam1 = _param1;
        
        if (__fromBentoScript)
        {
            //Force the scope of execution of BentoScript functions to the current context
            var _newScope = _scope ?? {};
            __function.setExecScope(_newScope);
            
            var _result = __function(_param0, _param1);
        }
        else
        {
            var _result = method(_scope, __function)(_param0, _param1);
        }
        
        _global.__currentCallback       = _oldCallback;
        _global.__currentCallbackScope  = _oldCallbackScope;
        _global.__currentCallbackParam0 = _oldCallbackParam0;
        _global.__currentCallbackParam1 = _oldCallbackParam1;
        
        return _result;
    }
    
    static __CallInherited = function(_scope, _param)
    {
        if (__parent == undefined) return;
        
        return __parent.__Call(_scope, _param);
    }
}