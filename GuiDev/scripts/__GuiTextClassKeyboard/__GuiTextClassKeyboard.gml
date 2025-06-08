// Feather disable all

/// @param initialText
/// @param maxLength

function __GuiTextClassKeyboard(_initialText, _maxLength) constructor
{
    _initialText = string_copy(_initialText, 1, _maxLength);
    
    static _system  = __GuiTextSystem();
    _system.__text  = _initialText;
    _system.__state = GUI_TEXT_PENDING;
    
    __maxLength = _maxLength;
    
    __keyboardStringPrev = _initialText;
    __keyboardString     = _initialText;
    keyboard_string      = _initialText;
    
    __timePrevious         = current_time;
    __backspacePressedTime = infinity;
    __backspaceIgnore      = false;
    __backspaceHeldPrev    = false;
    
    //Define a function to execute every frame in a time source
    var _stepFunction = function()
    {
        //Manually track backspaces
        var _backspaceRepeatCount = __UpdateBackspaceCount();
        
        //Collect the keyboard string
        __keyboardStringPrev = __keyboardString;
        __keyboardString = __GuiTextCleanUp(keyboard_string);
        
        //Detect changes between the two strings
        var _result = __GuiTextDetectChanges(__keyboardString, __keyboardStringPrev, _backspaceRepeatCount);
        
        //Modify the system's text string based on the removed characters and added characters
        _system.__text = __GuiTextApplyChanges(_system.__text, _result.__removeCount, _result.__textDelta, __maxLength);
        
        //Whacking [enter] finishes single-line entry
        if (keyboard_check(vk_enter))
        {
            __Terminate(GUI_TEXT_CONFIRM);
        }
    }
    
    //Set up that time source
    __timeSource = time_source_create(time_source_global, 1, time_source_units_frames, _stepFunction, [], -1);
    time_source_start(__timeSource);
    
    static __UpdateBackspaceCount = function()
    {
        var _backspaceRepeatCount = 0;
        
        var _currentTime    = current_time;
        var _backspaceCheck = keyboard_check(vk_backspace) && (not keyboard_check(vk_control)) && (not keyboard_check(vk_alt));
        var _backspaceHeld  = _backspaceCheck && ((keyboard_key == vk_backspace) || keyboard_check(ord(string_upper(keyboard_lastchar))));
        
        if (_backspaceHeld && keyboard_check_released(vk_anykey))
        {
            __backspacePressedTime = _currentTime;
        }            
        
        if (__backspaceIgnore && (not _backspaceCheck))
        {
            __backspaceIgnore = false;
        }
        else if (keyboard_check(vk_anykey) && (not _backspaceHeld))
        {
            __backspaceIgnore = true;
        }
        
        if ((not __backspaceIgnore) && _backspaceHeld)
        {
            if (not __backspaceHeldPrev)
            {
                //Initial press immediately removes a character
                _backspaceRepeatCount = 1;
                __backspacePressedTime = _currentTime;
            }
            else
            {
                //Held for more than one frame...
                
                var _heldTime = _currentTime - __backspacePressedTime;
                if (_heldTime < __GUI_BACKSPACE_REPEAT_DELAY)
                {
                    //No repeat
                    _backspaceRepeatCount = 0;
                }
                else
                {
                    var _repeatStart         = __backspacePressedTime + __GUI_BACKSPACE_REPEAT_DELAY;
                    var _repeatCountPrevious = floor((__timePrevious  - _repeatStart) / __GUI_BACKSPACE_REPEAT_INTERVAL);
                    var _repeatCountCurrent  = floor((_currentTime    - _repeatStart) / __GUI_BACKSPACE_REPEAT_INTERVAL);
                    _backspaceRepeatCount    = max(0, _repeatCountCurrent - _repeatCountPrevious);
                }
            }
        }
        
        __backspaceHeldPrev = _backspaceHeld;
        __timePrevious = _currentTime;
        
        return _backspaceRepeatCount;
    }
    
    static __Terminate = function(_state)
    {
        _system.__state = _state;
        
        if (__timeSource != undefined)
        {
            time_source_stop(__timeSource);
            time_source_destroy(__timeSource);
            __timeSource = undefined;
        }
    }
}