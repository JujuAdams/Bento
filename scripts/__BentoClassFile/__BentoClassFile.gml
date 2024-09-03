function __BentoClassFile(_path) constructor
{
    static _global      = __BentoGlobal();
    static _bentoScriptEnv = _global.__bentoScriptEnv;
    
    _global.__fileDict[$ _path] = self;
    array_push(_global.__fileArray, self);
    
    __hash = undefined;
    __path = _path;
    __absolutePath = _global.__fileDirectory + __path;
    
    __function = undefined;
    
    if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Created file state for ", string(self), "          ", debug_get_callstack());
    
    
    
    static toString = function()
    {
        return string(__path);
    }
    
    static __CheckForChanges = function()
    {
        var _fileHash = md5_file(__absolutePath);
        //if (BENTO_REPORT_LEVEL > 1) __BentoTrace(self, " file hash = ", _fileHash);
        return (__hash != _fileHash);
    }
    
    static __Load = function(_force)
    {
        if (!_force && (__hash != undefined)) return;
        
        if (BENTO_REPORT_LEVEL > 1) var _totalTime = get_timer();
        
        if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Loading ", string(self));
        
        if (BENTO_REPORT_LEVEL > 1) var _timer = get_timer();
        var _buffer = buffer_load(__absolutePath);
        if (BENTO_REPORT_LEVEL > 1) __BentoTrace((get_timer() - _timer)/1000, "ms read");
        
        if (BENTO_REPORT_LEVEL > 1)
        {
            var _oldHash = __hash;
            var _timer = get_timer();
        }
        
        __hash = md5_file(__absolutePath);
        if (BENTO_REPORT_LEVEL > 1) __BentoTrace((get_timer() - _timer)/1000, "ms hash (", _oldHash, " -> ", __hash, ", forced=", _force? "true" : "false", ")");
        
        try
        {
            if (BENTO_REPORT_LEVEL > 1) var _timer = get_timer();
            var _asg  = _bentoScriptEnv.parse(_buffer);
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
        
        buffer_delete(_buffer);
        
        if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Took ", (get_timer() - _totalTime)/1000, "ms to preload ", string(self));
    }
    
    static __Execute = function()
    {
        __Load(false);
        
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
            _result.__fileOrigin = __path;
        }
        else
        {
            if (_error != undefined) __BentoError("There was an error loading \"", __path, "\"\nIt did not return a valid UI struct");
        }
        
        if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Took ", (get_timer() - _timer)/1000, "ms to execute ", string(self), " (exc. any preload)");
        
        return _result;
    }
}