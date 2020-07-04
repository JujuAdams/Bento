/// @param selfSize
/// @param targetSize
/// @param rootSize
/// @param offset

function __bento_parse_offset(_s_size, _t_size, _r_size, _offset_input)
{
    if (is_numeric(_offset_input)) return _offset_input;
    if (!is_string(_offset_input)) return 0;
    
    var _offset       = 0;
    var _number       = 0;
    var _in_number    = false;
    var _number_start = 0;
    var _in_pc        = false;
    var _pc_type      = 0;
    var _is_negative  = false;
    
    _offset_input += "+";
    var _i = 1;
    repeat(string_length(_offset_input))
    {
        var _char = string_char_at(_offset_input, _i);
        
        switch(_char)
        {
            case "0":
            case "1":
            case "2":
            case "3":
            case "4":
            case "5":
            case "6":
            case "7":
            case "8":
            case "9":
            case ".":
                if (!_in_number)
                {
                    _number_start = _i;
                    _in_number = true;
                }
            break;
            
            default:
                if (_in_number)
                {
                    _in_number = false;
                    _number = real(string_copy(_offset_input, _number_start, _i - _number_start));
                }
                
                switch(_char)
                {
                    case "+":
                    case "-":
                        if (_in_pc)
                        {
                            switch(_pc_type)
                            {
                                case 0: _number *= _s_size/100; break;
                                case 1: _number *= _t_size/100; break;
                                case 2: _number *= _r_size/100; break;
                            }
                        }
                        
                        if (_is_negative)
                        {
                            _offset -= _number;
                        }
                        else
                        {
                            _offset += _number;
                        }
                        
                        _number = 0;
                        _is_negative = (_char == "-");
                    break;
                    
                    case "%":
                        _in_pc = true;
                        _pc_type = 0;
                    break;
                    
                    case "t":
                    case "T":
                        if (_in_pc)
                        {
                            _pc_type = 1;
                        }
                        else
                        {
                            throw "";
                        }
                    break;
                    
                    case "r":
                    case "R":
                        if (_in_pc)
                        {
                            _pc_type = 2;
                        }
                        else
                        {
                            throw "";
                        }
                    break;
                }
            break;
        }
        
        ++_i;
    }
    
    return _offset;
}