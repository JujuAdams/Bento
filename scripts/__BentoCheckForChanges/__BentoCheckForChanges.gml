function __BentoCheckForChanges()
{
    if (BENTO_HOT_RELOAD_MODE <= 0) return;
    
    static _global     = __BentoGlobal();
    static _fileArray  = _global.__fileArray;
    static _hostArray = _global.__hostArray;
    static _index      = 0;
    
    var _fileCount = array_length(_fileArray);
    if (_fileCount > 0)
    {
        static _inFocus = window_has_focus();
        
        var _repeats = 1;
        if (_inFocus != window_has_focus())
        {
            _inFocus = window_has_focus();
            if (window_has_focus())
            {
                if (BENTO_REPORT_LEVEL > 0) __BentoTrace("Window back in focus, refreshing all files");
                _repeats = _fileCount;
                _lastCheck = -infinity; //Force an immediate rescan
            }
        }
        
        static _lastCheck = -infinity;
        if (current_time - _lastCheck > (_inFocus? BENTO_HOT_RELOAD_SCAN_PERIOD_IN_FOCUS : BENTO_HOT_RELOAD_SCAN_PERIOD_OUT_OF_FOCUS))
        {
            _lastCheck = current_time;
            
            var _changedFilesArray = [];
            
            repeat(_repeats)
            {
                _index = (_index + 1) mod _fileCount;
                
                //if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Scanning ", _index, " = ", _fileArray[_index]);
                
                var _fileStruct = _fileArray[_index];
                if (_fileStruct.__CheckForChanges()) array_push(_changedFilesArray, _fileStruct);
            }
            
            var _changedCount = array_length(_changedFilesArray);
            if (_changedCount <= 0)
            {
                //No changes, just clean up the host array
                var _i = 0;
                repeat(array_length(_hostArray))
                {
                    if (weak_ref_alive(_hostArray[_i]))
                    {
                        ++_i;
                    }
                    else
                    {
                        array_delete(_hostArray, _i, 1);
                    }
                }
            }
            else
            {
                if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Changes detected in ", _changedFilesArray);
                
                //Reload all the changed files
                var _i = 0;
                repeat(_changedCount)
                {
                    var _fileStruct = _changedFilesArray[_i];
                    _fileStruct.__Load(true);
                    
                    //Replace the file struct reference with the path
                    _changedFilesArray[@ _i] = _fileStruct.__path;
                    
                    ++_i;
                }
                
                if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Paths are ", _changedFilesArray);
                
                //Find all boxes that have changed as a result
                var _changedBoxesArray = [];
                var _i = 0;
                repeat(array_length(_hostArray))
                {
                    if (weak_ref_alive(_hostArray[_i]))
                    {
                        _hostArray[_i].ref.__FileOriginSearch(_changedFilesArray, _changedBoxesArray);           
                        ++_i;
                    }
                    else
                    {
                        array_delete(_hostArray, _i, 1);
                    }
                }
                
                if (BENTO_REPORT_LEVEL > 1) __BentoTrace("Changed boxes are ", _changedBoxesArray);
                
                //And then reload them!
                var _i = 0;
                repeat(array_length(_changedBoxesArray))
                {
                    with(_changedBoxesArray[_i])
                    {
                        ReplaceFromFile(__fileOrigin);
                    }
                    
                    ++_i;
                }
            }
        }
    }
}