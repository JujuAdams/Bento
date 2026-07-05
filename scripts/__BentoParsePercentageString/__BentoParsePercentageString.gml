/// @param value
/// @param reference

function __BentoParsePercentageString(_value, _reference)
{
    if (not is_string(_value))
    {
        return _value;
    }
    
    var _posPerc = string_pos("%", _value);
    if (_posPerc <= 0)
    {
        try
        {
            _value = real(_value);
        }
        catch(_error)
        {
            return 0;
        }
    }
    
    try
    {
        _value = real(string_copy(_value, 1, _posPerc-1)) / 100;
    }
    catch(_error)
    {
        return 0;
    }
    
    return _value*_reference;
}