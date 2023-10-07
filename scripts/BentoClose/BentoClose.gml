/// Closes a box/layer that you're editing, and returns that box/layer.

function BentoClose()
{
    static _global = __BentoGlobal();
    
    var _stackSize = __BentoContextStackSize();
    if (_stackSize <= 1) __BentoError("Box stack already empty - check number of open/close command matches");
    
    //Handle basic behaviours on close
    var _current = __BentoContextStackTop();
    _current.__Close();
    
    //We want to run layouts on close in case 
    _current.__EventGet(__BENTO_EVENT.__LAYOUT).__Call(_current);
    
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
        
        var _i = 0;
        repeat(_layoutCount)
        {
            _array[_i].__LayoutExecute();
            ++_i;
        }
        
        //Start the build-in animation
        _current.BuildIn();
        
        //Actually pop the layer stack!
        __BentoLayerStackPop();
    }
    
    return _current;
}