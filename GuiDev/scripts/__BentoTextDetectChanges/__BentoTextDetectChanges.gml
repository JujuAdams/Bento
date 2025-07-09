// Feather disable all

/// @param keyboardString
/// @param keyboardStringPrev
/// @param backspaceRepeatCount

function __BentoTextDetectChanges(_keyboardString, _keyboardStringPrev, _backspaceRepeatCount)
{
    static _result = {
        __removeCount: 0,
        __textDelta: "",
    };
    
    var _keyboardStringLength = string_length(_keyboardString);
    
    //Detect new characters by scanning for positive differences
    if (_keyboardString != _keyboardStringPrev)
    {
        var _i = 1;
        repeat(_keyboardStringLength)
        {
            if (string_char_at(_keyboardString, _i) != string_char_at(_keyboardStringPrev, _i)) break;
            ++_i;
        }
        
        _result.__textDelta = string_copy(_keyboardString, _i, _keyboardStringLength);
    }
    else
    {
        _result.__textDelta = "";
    }
    
    //Figure out how many characters have been deleted
    if (string_length(_keyboardStringPrev) <= 0)
    {
        _result.__removeCount = _backspaceRepeatCount;
    }
    else
    {
        var _deleteCount = abs(_keyboardStringLength - string_length(_keyboardStringPrev) - string_length(_result.__textDelta));
        if (_deleteCount != 0)
        {
            _result.__removeCount = _deleteCount;
        }
        else
        {
            _result.__removeCount = (BENTO_ON_MACOS || BENTO_ON_LINUX)? _backspaceRepeatCount : 0;
        }
    }
    
    return _result;
}