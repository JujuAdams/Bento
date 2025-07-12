// Feather disable all

/// @param environment
/// @param initialText
/// @param callback
/// @param maxLength
/// @param keyboardType
/// @param returnKey
/// @param capitalization
/// @param textPrediction

function __BentoTextClassiOS(_environment, _initialText, _callback, _maxLength, _keyboardType, _returnKey, _capitalization, _textPrediction) : __BentoTextClassShared(_environment, _initialText, _callback, _maxLength) constructor
{
    static __cancelOnClick = true;
    
    __keyboardType   = _keyboardType;
    __returnKey      = _returnKey;
    __capitalization = _capitalization;
    __textPrediction = _textPrediction;
    
    __keyboardStringPrev = __text;
    __keyboardString     = __text;
    keyboard_string      = __text;
    
    __osPausedPrev      = os_is_paused();
    __virtualStatusPrev = false;
    
    keyboard_virtual_show(__keyboardType, __returnKey, __capitalization, __textPrediction);
    
    __Callback();
    
    
    
    static __Step = function()
    {
        var _keyboardString = keyboard_string;
        var _keyboardStringLength = string_length(_keyboardString);
        
        if (_keyboardStringLength > __BENTO_TEXT_IOS_MAX)
        {
            __Terminate(BENTO_TEXT_ERROR);
            return;
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
            __Terminate(BENTO_TEXT_CONFIRM);
            return;
        }                
        else if ((not _osPaused) && (not _virtualStatus) && __virtualStatusPrev)
        {
            __Terminate(BENTO_TEXT_ABORT);
            return;
        }
        
        __virtualStatusPrev = _virtualStatus;
        
        //Collect the keyboard string
        __keyboardStringPrev = __keyboardString;
        __keyboardString = __BentoTextCleanUp(_keyboardString);
        
        //Detect changes between the two strings
        var _result = __BentoTextDetectChanges(__keyboardString, __keyboardStringPrev, 0);
        
        //Modify the system's text string based on the removed characters and added characters
        __text = __BentoTextApplyChanges(__text, _result.__removeCount, _result.__textDelta, __maxLength);
        
        __Callback();
    }
    
    static __Terminate = function(_state)
    {
        keyboard_virtual_hide();
        
        __TerminateShared(_state);
    }
}