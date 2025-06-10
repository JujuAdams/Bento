// Feather disable all

/// @param environment
/// @param initialText
/// @param callback
/// @param maxLength
/// @param caption

function __GuiTextClassSteam(_environment, _initialText, _callback, _maxLength, _caption) : __GuiTextClassShared(_environment, _initialText, _callback, _maxLength) constructor
{
    __caption = _caption;
    
    var _result = steam_show_gamepad_text_input(steam_gamepad_text_input_mode_normal,
                                                steam_gamepad_text_input_line_mode_single_line, 
                                                __caption, __maxLength, __initialText);                
    if (_result)
    {
        __GuiTextEnsureController().__steam = self;
        __Callback();
    }
    else
    {
        show_debug_message("Failed to open Steam gamepad text input");
        __Terminate(GUI_TEXT_ABORT);
        return;
    }
    
    
    
    static __Step = function()
    {
        if (__state == GUI_TEXT_PENDING)
        {
            __GuiTextEnsureController().__steam = self;
        }
    }
    
    static __AsyncEvent = function()
    {
        if (async_load[? "event_type"] == "gamepad_text_input_dismissed")
        {
            if (not async_load[? "submitted"])
            {
                __Terminate(GUI_TEXT_ABORT);
            }
            else if (__state == GUI_TEXT_PENDING)
            {
                __text = string_copy(steam_get_entered_gamepad_text_input(), 1, __maxLength);
                __Terminate(GUI_TEXT_CONFIRM);
            }
        }
    }
    
    static __Terminate = function(_state)
    {
        with(__GuiTextAsyncController)
        {
            __steam = undefined;
            instance_destroy();
        }
        
        __TerminateShared(_state);
    }
}