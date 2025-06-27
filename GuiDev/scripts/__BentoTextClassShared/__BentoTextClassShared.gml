// Feather disable all

/// @param environment
/// @param initialText
/// @param callback
/// @param maxLength

function __BentoTextClassShared(_environment, _initialText, _callback, _maxLength) constructor
{
    static _system = __BentoSystem();
    static __cancelOnClick = false;
    
    __environment = _environment;
    __text        = _initialText;
    __callback    = _callback;
    __maxLength   = _maxLength;
    
    __openFrame = _system.__frame;
    
    __state = BENTO_TEXT_PENDING;
    
    
    
    static __Callback = function()
    {
        if (not is_callable(__callback)) return;
        __callback(__text, __state);
    }
    
    static __TerminateShared = function(_state)
    {
        var _self = self;
        
        __state = _state;
        
        with(_system)
        {
            if (_self.__environment == __textHandlerEnvironment)
            {
                with(__textHandlerEnvironment)
                {
                    if (__textHandler == _self)
                    {
                        __textHandler = undefined;
                        __textElement = undefined;
                        
                        //Make sure our layer is updated
                        __layerCurrent.__dirtyFlags |= __BENTO_DIRTY_STEP | __BENTO_DIRTY_HOVERABLE;
                    }
                }
                
                __textHandlerEnvironment = undefined;
            }
        }
        
        __Callback();
    }
}