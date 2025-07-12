// Feather disable all

/// @param environment
/// @param initialText
/// @param callback
/// @param maxLength
/// @param caption

function __BentoTextClassDialog(_environment, _initialText, _callback, _maxLength, _caption) : __BentoTextClassShared(_environment, _initialText, _callback, _maxLength) constructor
{
    __caption = _caption;
    
    __asyncID = get_string_async(_caption, _initialText);
    if (__asyncID >= 0)
    {
        __BentoTextEnsureController().__dialog = self;
        __Callback();
    }
    else
    {
        show_debug_message("Failed to open dialog window");
        __Terminate(BENTO_TEXT_ABORT);
        return;
    }
    
    
    
    static __Step = function()
    {
        if (__state == BENTO_TEXT_PENDING)
        {
            __BentoTextEnsureController().__dialog = self;
        }
    }
    
    static __AsyncEvent = function()
    {
        if (async_load[? "id"] == __asyncID)
        {
            var _result = async_load[? "result"];
            if ((not async_load[? "status"]) || (_result == undefined))
            {
                __Terminate(BENTO_TEXT_ABORT);
            }
            else
            {
                __text = string_copy(_result, 1, __maxLength);
                __Terminate(BENTO_TEXT_CONFIRM);
            }
        }
    }
    
    static __Terminate = function(_state)
    {
        __asyncID = undefined;
        
        with(__BentoTextAsyncController)
        {
            __dialog = undefined;
            instance_destroy();
        }
        
        __TerminateShared(_state);
    }
}