/// @param value
/// @param reference

function __BentoParsePercentageString(_string, _reference)
{
    static _percentageParseDict = __BentoSystem().__percentageParseDict;
    static _buffer = buffer_create(64, buffer_grow, 1);
    
    if (not is_string(_string))
    {
        return _string;
    }
    
    var _result = _percentageParseDict[$ _string];
    if (_result == undefined)
    {
        _result = {
            __offset: 0,
            __coeff: 0,
        };
        
        _percentageParseDict[$ _string] = _result;
        
        buffer_seek(_buffer, buffer_seek_start, 0);
        buffer_poke(_buffer, 0, buffer_string, _string);
        
        var _tokenArray = [];
        if (not __BentoPercentageTokenize(_buffer, _tokenArray))
        {
            __BentoTrace($"Failed to tokenize \"{_string}\"");
        }
        else if (not __BentoEvaluate(_tokenArray, _result))
        {
            __BentoTrace($"Failed to evaluate \"{_string}\" {_tokenArray}");
            _result.__offset = 0;
            _result.__coeff  = 0;
        }
    }
    
    return _result.__offset + _reference*_result.__coeff;
}

function __BentoEvaluate(_tokenArray, _result)
{
    var _value = undefined;
    var _isCoefficent = false;
    
    var _i = array_length(_tokenArray)-1;
    repeat(array_length(_tokenArray))
    {
        var _token = _tokenArray[_i];
        if (_token == "-")
        {
            if (_value == undefined)
            {
                __BentoTrace($"Parse error: two adjacent `-` symbols found");
                return false;
            }
            else
            {
                if (_isCoefficent)
                {
                    _result.__coeff -= _value/100;
                }
                else
                {
                    _result.__offset -= _value;
                }
                
                _value = undefined;
                _isCoefficent = false;
            }
        }
        else if (_token == "+")
        {
            if (_value == undefined)
            {
                __BentoTrace($"Parse error: two adjacent `+` symbols found");
                return false;
            }
            else
            {
                if (_isCoefficent)
                {
                    _result.__coeff += _value/100;
                }
                else
                {
                    _result.__offset += _value;
                }
                
                _value = undefined;
                _isCoefficent = false;
            }
        }
        else if (_token == "%")
        {
            if (_isCoefficent)
            {
                __BentoTrace($"Parse error: two adjacent `%` symbols found");
                return false;
            }
            else
            {
                _isCoefficent = true;
            }
        }
        else if (is_numeric(_token))
        {
            if (_value == undefined)
            {
                _value = _token;
            }
            else
            {
                __BentoTrace($"Parse error: two adjacent numeric tokens found");
                return false;
            }
        }
        
        --_i;
    }
    
    if (_value != undefined)
    {
        if (_isCoefficent)
        {
            _result.__coeff += _value/100;
        }
        else
        {
            _result.__offset += _value;
        }
    }
    
    return true;
}

function __BentoPercentageTokenize(_buffer, _tokenArray)
{
    while(true)
    {
        var _byte = buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8);
        if (_byte == 0x00)
        {
            return true;
        }
        else if ((_byte >= 0x30) && (_byte <= 0x39)) //Number
        {
            var _number = 0;
            var _decimalSeparator = false;
            var _decimalMultiplier = 1;
            
            while(true)
            {
                var _byte = buffer_peek(_buffer, buffer_tell(_buffer), buffer_u8);
                if (_byte == 0x2e)
                {
                    if (_decimalSeparator)
                    {
                        __BentoTrace($"Parse error: two decimal separators found");
                        return false;
                    }
                    else
                    {
                        _decimalSeparator = true;
                    }
                    
                    buffer_seek(_buffer, buffer_seek_relative, 1);
                }
                else if ((_byte >= 0x30) && (_byte <= 0x39))
                {
                    if (_decimalSeparator)
                    {
                        _decimalMultiplier /= 10;
                        _number += _decimalMultiplier*(_byte - 0x30);
                    }
                    else
                    {
                        _number = 10*_number + (_byte - 0x30);
                    }
                    
                    buffer_seek(_buffer, buffer_seek_relative, 1);
                }
                else if ((_byte == 0x00) || (_byte == 0x20) || (_byte == 0x25) || (_byte == 0x2b) || (_byte == 0x2d))
                {
                    array_push(_tokenArray, _number);
                    break;
                }
                else
                {
                    __BentoTrace($"Parse error: byte 0d{_byte} unexpected");
                    return false;
                }
            }
        }
        else if (_byte == 0x25) //Percent
        {
            array_push(_tokenArray, "%");
            buffer_seek(_buffer, buffer_seek_relative, 1);
        }
        else if (_byte == 0x2b) //Plus
        {
            array_push(_tokenArray, "+");
            buffer_seek(_buffer, buffer_seek_relative, 1);
        }
        else if (_byte == 0x2d) //Subtract/negative
        {
            array_push(_tokenArray, "-");
            buffer_seek(_buffer, buffer_seek_relative, 1);
        }
        else if (_byte == 0x20) //Space
        {
            buffer_seek(_buffer, buffer_seek_relative, 1);
        }
        else
        {
            __BentoTrace($"Parse error: byte 0d{_byte} unexpected");
            return false;
        }
    }
    
    return true;
}