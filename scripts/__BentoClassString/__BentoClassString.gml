function __BentoClassString(_string) constructor
{
    static _global      = __BentoGlobal();
    static _bentoScriptEnv = _global.__bentoScriptEnv;
    
    _global.__stringDict[$ _string] = self;
    array_push(_global.__stringArray, self);
    
    
    
    
    
    __name     = "<string " + string(debug_get_callstack()[3]) + ">";
    __function = undefined;
    
    if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Created string container for ", string(self), "          ", debug_get_callstack());
    
    if (BENTO_REPORT_LEVEL > 1) var _totalTime = get_timer();
    
    try
    {
        if (BENTO_REPORT_LEVEL > 1) var _timer = get_timer();
        var _asg  = _bentoScriptEnv.parseString(_string);
        if (BENTO_REPORT_LEVEL > 1) __BentoTrace((get_timer() - _timer)/1000, "ms BentoScript parse");
        
        if (BENTO_REPORT_LEVEL > 1) var _timer = get_timer();
        __function = _bentoScriptEnv.compileGML(_asg);
        if (BENTO_REPORT_LEVEL > 1) __BentoTrace((get_timer() - _timer)/1000, "ms BentoScript compile");
    }
    catch(_error)
    {
        if (BENTO_REPORT_LEVEL > 1) __BentoTrace(_error);
        
        __function = function() {};
    }
    
    if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Took ", (get_timer() - _totalTime)/1000, "ms to preload ", string(self));
    
    
    
    
    
    static toString = function()
    {
        return __name;
    }
    
    static __Execute = function()
    {
        if (BENTO_REPORT_LEVEL > 1) var _timer = get_timer();
        
        var _result = undefined;
        
        var _error = undefined;
        try
        {
            _result = __function();
        }
        catch(_error)
        {
            __BentoTrace(_error);
        }
        
        if (is_struct(_result))
        {
            _result.__fileOrigin = undefined;
        }
        else
        {
            if (_error != undefined) __BentoError("There was an error executing ", self, "\nIt did not return a valid UI struct");
        }
        
        if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Took ", (get_timer() - _timer)/1000, "ms to execute ", self, " (exc. any preload)");
        
        return _result;
    }
}