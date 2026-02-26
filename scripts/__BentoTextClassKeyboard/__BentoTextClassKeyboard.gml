// Feather disable all

/// @param environment
/// @param initialText
/// @param callback
/// @param maxLength

function __BentoTextClassKeyboard(_environment, _initialText, _callback, _maxLength) : __BentoTextClassShared(_environment, _initialText, _callback, _maxLength) constructor
{
    static __cancelOnClick = true;
    
    keyboard_string = "";
    __lastInputTime = current_time;
    
    __Callback();
    
    
    
    static __Step = function()
    {
        //Automatically abort if there's been no input for 10 seconds
        if (keyboard_check(vk_anykey))
        {
            __lastInputTime = current_time;
        }
        else if (current_time - __lastInputTime > 10_000)
        {
            __Terminate(BENTO_TEXT_ABORT);
            return;
        }
        
        if (BentoHotkeyGetPress(BENTO_HOTKEY_CANCEL, true))
        {
            BentoInputConsume();
            __Terminate(BENTO_TEXT_ABORT);
            return;
        }
        
        if (keyboard_check_pressed(vk_backspace))
        {
            __text = string_copy(__text, 1, string_length(__text)-1);
        }
        
        __text += __BentoTextCleanUp(keyboard_string);
        keyboard_string = "";
        
        //Whacking [enter] finishes single-line entry
        if (keyboard_check(vk_enter))
        {
            __Terminate(BENTO_TEXT_CONFIRM);
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