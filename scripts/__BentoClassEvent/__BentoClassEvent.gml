function __BentoClassEvent(_parent, _function, _fromBentoScript, _type) constructor
{
    static _global = __BentoGlobal();
    
    __parent          = _parent;
    __function        = _function;
    __fromBentoScript = _fromBentoScript;
    __type            = _type;
    
    static __Call = function(_scope, _param0, _param1)
    {
        if (__function == undefined) return;
        
        var _oldEvent       = _global.__currentEvent;
        var _oldEventScope  = _global.__currentEventScope;
        var _oldEventParam0 = _global.__currentEventParam0;
        var _oldEventParam1 = _global.__currentEventParam1;
        
        _global.__currentEvent       = self;
        _global.__currentEventScope  = _scope;
        _global.__currentEventParam0 = _param0;
        _global.__currentEventParam1 = _param1;
        
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
        
        _global.__currentEvent       = _oldEvent;
        _global.__currentEventScope  = _oldEventScope;
        _global.__currentEventParam0 = _oldEventParam0;
        _global.__currentEventParam1 = _oldEventParam1;
        
        return _result;
    }
    
    static __CallInherited = function(_scope, _param)
    {
        if (__parent == undefined) return;
        
        return __parent.__Call(_scope, _param);
    }
}