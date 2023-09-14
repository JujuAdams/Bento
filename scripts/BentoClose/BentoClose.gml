/// Closes a box/layer that you're editing, and returns that box/layer

function BentoClose()
{
    static _global = __BentoGlobal();
    
    var _stackSize = __BentoContextStackSize();
    if (_stackSize <= 1) __BentoError("Box stack already empty - check number of open/close command matches");
    
    //Handle basic behaviours on close
    var _current = __BentoContextStackTop();
    _current.__Close();
    
    //We want to run layouts on close in case 
    _current.__CallbackGet(__BENTO_CALL.__LAYOUT_EXECUTE).__Call(_current);
    
    //Pop context set elsewhere (typically BentoOpenExisting() or layer creation methods in BentoClassHost)
    __BentoContextStackPop();
    __BentoScriptScopePop();
    
    if (_current.__popLayerOnClose)
    {
        _current.__popLayerOnClose = false; //Better reset this for next time...
        
        //Since we might be iterating pretty hard here, let's precache what order to process boxes
        var _array = [];
        _current.__LayoutBuildOrder(_array);
        var _layoutCount = array_length(_array);
        
        //Repeat a few times
        //We break out early if nothing changed
        repeat(BENTO_LAYOUT_MAX_REPETITIONS)
        {
            var _dirty = false;
            
            var _i = 0;
            repeat(_layoutCount)
            {
                _array[_i].__LayoutExecute();
                ++_i;
            }
            
            var _i = _layoutCount-1;
            repeat(_layoutCount)
            {
                if (not (_array[_i].__LayoutCheck() ?? true))
                {
                    _dirty = true;
                    break;
                }
                
                --_i;
            }
            
            if (not _dirty) break;
        }
        
        //Start the build-in animation
        _current.BuildIn();
        
        //Actually pop the layer stack!
        __BentoLayerStackPop();
    }
    
    return _current;
}