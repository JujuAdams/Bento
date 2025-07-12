// Feather disable all

/// @param string
/// @param removeCount
/// @param addString
/// @param maxLength

function __BentoTextApplyChanges(_string, _removeCount, _addString, _maxLength)
{
    if (_removeCount > 0)
    {
        _string = string_copy(_string, 1, max(0, string_length(_string) - _removeCount));
    }
    
    _string = string_copy(_string + _addString, 1, _maxLength);
    
    //_string += _addString;
    //
    //If the player has typed too many characters, shift the string
    //var _overflowCount = string_length(_string) - _maxLength;
    //if (_overflowCount > 0)
    //{
    //    _string = string_copy(_string, _overflowCount+1, _maxLength);
    //}
    
    return _string;
}