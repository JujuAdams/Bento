// Feather disable all

/// @param environment
/// @param initialText
/// @param callback
/// @param maxLength
/// @param caption

function __BentoTextClassSteam(_environment, _initialText, _callback, _maxLength, _caption) : __BentoTextClassShared(_environment, _initialText, _callback, _maxLength) constructor
{
    __caption = _caption;
    
    var _result = steam_show_gamepad_text_input(steam_gamepad_text_input_mode_normal,
                                                steam_gamepad_text_input_line_mode_single_line, 
                                                __caption, __maxLength, __initialText);                
    if (_result)
    {
        __BentoTextEnsureController().__steam = self;
        __Callback();
    }
    else
    {
        show_debug_message("Failed to open Steam gamepad text input");
        __Terminate(BENTO_TEXT_ERROR);
        return;
    }
    
    
    
    static __Step = function()
    {
        if (__state == BENTO_TEXT_PENDING)
        {
            __BentoTextEnsureController().__steam = self;
        }
    }
    
    static __AsyncEvent = function()
    {
        if (async_load[? "event_type"] == "gamepad_text_input_dismissed")
        {
            if (not async_load[? "submitted"])
            {
                __Terminate(BENTO_TEXT_ABORT);
            }
            else if (__state == BENTO_TEXT_PENDING)
            {
                __text = string_copy(steam_get_entered_gamepad_text_input(), 1, __maxLength);
                __Terminate(BENTO_TEXT_CONFIRM);
            }
        }
    }
    
    static __Terminate = function(_state)
    {
        with(__BentoTextAsyncController)
        {
            __steam = undefined;
            instance_destroy();
        }
        
        __TerminateShared(_state);
    }
}