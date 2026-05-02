/// @param array2D
/// @param [headerRow]

function __BentoArray2DToFormattedTable(_rootArray, _headerRow = undefined)
{
    if (not is_array(_rootArray))
    {
        return "";
    }
    
    if (is_array(_headerRow))
    {
        var _hasHeaderRow = true;
        array_insert(_rootArray, 0, _headerRow);
    }
    else
    {
        var _hasHeaderRow = false;
    }
    
    var _rows = array_length(_rootArray);
    if (_rows <= 0)
    {
        return "";
    }
    
    var _columns = array_length(_rootArray[0]);
    if (_columns <= 0)
    {
        return "";
    }
    
    var _columnSizeArray = array_create(_columns, 0);
    
    var _y = 0;
    repeat(_rows)
    {
        var _rowArray = _rootArray[_y];
        if (is_array(_rowArray))
        {
            var _x = 0;
            repeat(array_length(_rowArray))
            {
                _columnSizeArray[@ _x] = max(_columnSizeArray[_x], string_length(string(_rowArray[_x])));
                ++_x;
            }
        }
        
        ++_y;
    }
    
    var _buffer = buffer_create(1024, buffer_grow, 1);
    
    var _y = 0;
    repeat(_rows)
    {
        var _rowArray = _rootArray[_y];
        if (is_array(_rowArray))
        {
            var _x = 0;
            repeat(min(_columns, array_length(_rowArray)))
            {
                buffer_write(_buffer, buffer_u8, ord("|"));
                buffer_write(_buffer, buffer_u8, ord(" "));
                
                //Write value
                var _string = string(_rowArray[_x]);
                buffer_write(_buffer, buffer_text, _string);
                
                //Pad
                repeat(_columnSizeArray[@ _x] - string_length(_string))
                {
                    buffer_write(_buffer, buffer_u8, ord(" "));
                }
                
                buffer_write(_buffer, buffer_u8, ord(" "));
                
                ++_x;
            }
            
            //Add empty cells if the row array is too short
            repeat(_columns - _x)
            {
                buffer_write(_buffer, buffer_u8, ord("|"));
                buffer_write(_buffer, buffer_u8, ord(" "));
                
                //Pad
                repeat(_columnSizeArray[@ _x] - string_length(_string))
                {
                    buffer_write(_buffer, buffer_u8, ord(" "));
                }
                
                buffer_write(_buffer, buffer_u8, ord(" "));
                
                ++_x;
            }
        }
        
        buffer_write(_buffer, buffer_u8, ord("|"));
        buffer_write(_buffer, buffer_u8, ord("\n"));
            
        if (_hasHeaderRow && (_y == 0))
        {
            var _x = 0;
            repeat(_columns)
            {
                buffer_write(_buffer, buffer_u8, ord("|"));
                    
                repeat(_columnSizeArray[_x] + 2)
                {
                    buffer_write(_buffer, buffer_u8, ord("-"));
                }
                
                ++_x;
            }
            
            buffer_write(_buffer, buffer_u8, ord("|"));
            buffer_write(_buffer, buffer_u8, ord("\n"));
        }
        
        ++_y;
    }
    
    buffer_poke(_buffer, buffer_tell(_buffer)-1, buffer_u8, 0x00);
    var _string = buffer_peek(_buffer, 0, buffer_string);
    buffer_delete(_buffer);
    
    if (_hasHeaderRow)
    {
        array_delete(_rootArray, 0, 1);
    }
    
    return _string;
}