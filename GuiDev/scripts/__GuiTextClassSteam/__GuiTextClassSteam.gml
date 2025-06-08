// Feather disable all

/// @param initialText
/// @param caption
/// @param maxLength

function __GuiTextClassSteam(_initialText, _caption, _maxLength) constructor
{
    _initialText = string_copy(_initialText, 1, _maxLength);
    
    static _textSystem = __GuiSystem().__textContainer;
    //Don't set `__text` here. We only set `__text` when the player confirms the dialog
    _textSystem.__state = GUI_TEXT_PENDING;
    
    __caption   = _caption;
    __maxLength = _maxLength;
    
    __timeSource = undefined;
    
    var _result = steam_show_gamepad_text_input(steam_gamepad_text_input_mode_normal,
                                                steam_gamepad_text_input_line_mode_single_line, 
                                                _caption, _maxLength, _initialText);                
    if (_result)
    {
        __GuiTextEnsureController().__steam = self;
    }
    else
    {
        show_debug_message("Failed to open Steam gamepad text input");
        __Terminate(GUI_TEXT_ABORT);
        return;
    }
    
    //Create a time source to ensure the controller is still alive
    __timeSource = time_source_create(time_source_global, 1, time_source_units_frames, function()
    {
        if (_textSystem.__state == GUI_TEXT_PENDING)
        {
            __GuiTextEnsureController().__steam = self;
        }
    },
    [], -1);
    time_source_start(__timeSource);
    
    static __AsyncEvent = function()
    {
        if (async_load[? "event_type"] == "gamepad_text_input_dismissed")
        {
            if (not async_load[? "submitted"])
            {
                __Terminate(GUI_TEXT_ABORT);
            }
            else if (_textSystem.__state == GUI_TEXT_PENDING)
            {
                _textSystem.__text = string_copy(steam_get_entered_gamepad_text_input(), 1, __maxLength);
                __Terminate(GUI_TEXT_CONFIRM);
            }
        }
    }
    
    static __Terminate = function(_state)
    {
        with(_textSystem)
        {
            __state = _state;
            
            __GuiFocusCloseInner(__hostElement);
            __hostElement = undefined;
        }
        
        if (__timeSource != undefined)
        {
            time_source_stop(__timeSource);
            time_source_destroy(__timeSource);
            __timeSource = undefined;
        }
        
        with(__GuiTextAsyncController)
        {
            __steam = undefined;
            instance_destroy();
        }
    }
}