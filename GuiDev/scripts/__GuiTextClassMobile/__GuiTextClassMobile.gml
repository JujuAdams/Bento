// Feather disable all

/// @param initialText
/// @param maxLength
/// @param mobileSettings

function __GuiTextClassMobile(_initialText, _maxLength, _mobileSettings) constructor
{
    _initialText = string_copy(_initialText, 1, _maxLength);
    
    static _textSystem  = __GuiSystem().__textContainer;
    _textSystem.__text  = _initialText;
    _textSystem.__state = GUI_TEXT_PENDING;
    
    __keyboardType   = _mobileSettings[$ "keyboardType"  ] ?? kbv_type_default;
    __returnKey      = _mobileSettings[$ "returnKey"     ] ?? kbv_returnkey_default;
    __capitalization = _mobileSettings[$ "capitalization"] ?? kbv_autocapitalize_none;
    __textPrediction = _mobileSettings[$ "textPrediction"] ?? false;
    
    __maxLength = _maxLength;
    
    __keyboardStringPrev = _initialText;
    __keyboardString     = _initialText;
    keyboard_string      = _initialText;
    
    __osPausedPrev      = os_is_paused();
    __virtualStatusPrev = false;
    
    keyboard_virtual_show(__keyboardType, __returnKey, __capitalization, __textPrediction);
    
    //Define a function to execute every frame in a time source
    var _stepFunction = function()
    {
        var _keyboardString = keyboard_string;
        var _keyboardStringLength = string_length(_keyboardString);
        
        if (GUI_ON_IOS)
        {
            if (_keyboardStringLength > __GUI_TEXT_IOS_MAX)
            {
                __Terminate(GUI_TEXT_ABORT);
                return;
            }
        }
        
        //Keep the virtual keyboard visible
        var _osPaused = os_is_paused();
        
        if ((not _osPaused) && __osPausedPrev)
        {
            keyboard_virtual_show(__keyboardType, __returnKey, __capitalization, __textPrediction);
        }
        
        __osPausedPrev = _osPaused;
        
        //Detect the final character in the incoming string
        var _tail = 0x00;
        if (_keyboardStringLength > string_length(__keyboardStringPrev))
        {
            var _tail = ord(string_char_at(_keyboardString, _keyboardStringLength));
        }
        
        //We receive a line feed/carriage return if the user has confirmed the dialog
        var _virtualStatus = keyboard_virtual_status();
        
        if (keyboard_check_pressed(0x0A) || (_tail == 0x0A)  // Line feed
        ||  keyboard_check_pressed(0x0D) || (_tail == 0x0D)) // Carriage return
        {
            __Terminate(GUI_TEXT_CONFIRM);
            return;
        }                
        else if ((not _osPaused) && (not _virtualStatus) && __virtualStatusPrev)
        {
            __Terminate(GUI_TEXT_ABORT);
            return;
        }
        
        __virtualStatusPrev = _virtualStatus;
        
        //Collect the keyboard string
        __keyboardStringPrev = __keyboardString;
        __keyboardString = __GuiTextCleanUp(_keyboardString);
        
        //Detect changes between the two strings
        var _result = __GuiTextDetectChanges(__keyboardString, __keyboardStringPrev, 0);
        
        //Modify the system's text string based on the removed characters and added characters
        _textSystem.__text = __GuiTextApplyChanges(_textSystem.__text, _result.__removeCount, _result.__textDelta, __maxLength);
    }
    
    //Set up that time source
    __timeSource = time_source_create(time_source_global, 1, time_source_units_frames, _stepFunction, [], -1);
    time_source_start(__timeSource);
    
    static __Terminate = function(_state)
    {
        with(_textSystem)
        {
            __state = _state;
            
            __GuiFocusCloseInner(__hostElement);
            __hostElement = undefined;
        }
        
        keyboard_virtual_hide();
        
        if (__timeSource != undefined)
        {
            time_source_stop(__timeSource);
            time_source_destroy(__timeSource);
            __timeSource = undefined;
        }
    }
}