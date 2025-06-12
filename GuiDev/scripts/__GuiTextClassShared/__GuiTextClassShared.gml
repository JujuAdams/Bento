// Feather disable all

/// @param environment
/// @param initialText
/// @param callback
/// @param maxLength

function __GuiTextClassShared(_environment, _initialText, _callback, _maxLength) constructor
{
    static _system = __GuiSystem();
    static __cancelOnClick = false;
    
    __environment = _environment;
    __text        = _initialText;
    __callback    = _callback;
    __maxLength   = _maxLength;
    
    __openFrame = _system.__frame;
    
    __state = GUI_TEXT_PENDING;
    
    
    
    static __Callback = function()
    {
        if (not is_callable(__callback)) return;
        __callback(__text, __state);
    }
    
    static __TerminateShared = function(_state)
    {
        __state = _state;
        
        with(__environment)
        {
            if (__textHandler == other) __textHandler = undefined;
            __textElement = undefined;
            
            //Make sure our layer is updated
            __layerCurrent.__dirtyFlags |= __GUI_DIRTY_STEP | __GUI_DIRTY_HOVERABLE;
        }
        
        __Callback();
    }
}