/// @param value
/// @param reference

function __BentoParsePercentageString(_value, _reference)
{
    static _percentageParseDict = __BentoSystem().__percentageParseDict;
    
    if (not is_string(_value))
    {
        return _value;
    }
    
    var _result = _percentageParseDict[$ _value];
    if (_result == undefined)
    {
        _result = {
            __offset: 0,
            __coeff: 0,
        };
        
        _percentageParseDict[$ _value] = _result;
        
        var _posPerc = string_pos("%", _value);
        if (_posPerc <= 0)
        {
            try
            {
                _result.__offset = real(_value);
            }
            catch(_error)
            {
                
            }
        }
        
        try
        {
            _result.__coeff = real(string_copy(_value, 1, _posPerc-1)) / 100;
        }
        catch(_error)
        {
            
        }
    }
    
    return _result.__offset + _reference*_result.__coeff;
}