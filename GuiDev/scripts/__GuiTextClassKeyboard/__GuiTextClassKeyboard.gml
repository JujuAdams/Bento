// Feather disable all

/// @param environment
/// @param initialText
/// @param callback
/// @param maxLength

function __GuiTextClassKeyboard(_environment, _initialText, _callback, _maxLength) : __GuiTextClassShared(_environment, _initialText, _callback, _maxLength) constructor
{
    keyboard_string = "";
    
    __Callback();
    
    
    
    static __Step = function()
    {
        if (keyboard_check_pressed(vk_backspace))
        {
            __text = string_copy(__text, 1, string_length(__text)-1);
        }
        
        __text += __GuiTextCleanUp(keyboard_string);
        keyboard_string = "";
        
        //Whacking [enter] finishes single-line entry
        if (keyboard_check(vk_enter))
        {
            __Terminate(GUI_TEXT_CONFIRM);
        }
        else
        {
            __Callback();
        }
    }
    
    static __Terminate = function(_state)
    {
        __TerminateShared(_state);
    }
}