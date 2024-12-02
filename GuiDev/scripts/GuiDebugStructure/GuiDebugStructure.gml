// Feather disable all

/// Returns a human-readable "ASCII art" diagram showing the structure of the input struct/array.
/// 
/// @param [parent=root]
/// @param [ascii=false]  Whether to use ASCII compatibility mode

function GuiDebugStructure(_parent = GUI_ROOT, _ascii = false, _method = undefined)
{
    if (not instance_exists(_parent)) return "<Instance doesn't exist>";
    
    static _internalMethod = function(_nameArray)
    {
        if (__behavior != GUI_BEHAVIOR_BUTTON) array_push(_nameArray, "behavior", GuiFriendlyBehavior(__behavior));
        if (variable_instance_exists(self, "text")) array_push(_nameArray, "text", text);
        
        array_push(_nameArray, "width",  sprite_width);
        array_push(_nameArray, "height", sprite_height);
        
        if (__overState != GUI_OFF) array_push(_nameArray, "over", GuiFriendlyOverState(__overState));
        if (__holdState != GUI_OFF) array_push(_nameArray, "hold", GuiFriendlyHoldState(__holdState));
        
        if (array_length(__childInsideArray) != 0) array_push(_nameArray, "inside", __childInsideArray);
        if (array_length(__childOutsideArray) != 0) array_push(_nameArray, "outside", __childOutsideArray);
    }
    
    static _buffer = buffer_create(1024, buffer_grow, 1);
    buffer_seek(_buffer, buffer_seek_start, 0);
    
    if (_ascii)
    {
        __GuiDebugStructureASCIIInner(_buffer, " ", _parent, _method ?? _internalMethod);
    }
    else
    {
        __GuiDebugStructureInner(_buffer, " ", _parent, _method ?? _internalMethod);
    }
    
    buffer_write(_buffer, buffer_u8, 0x00);
    return buffer_peek(_buffer, 0, buffer_string);
}

function __GuiDebugStructureInner(_buffer, _prefix, _value, _method)
{
    static _funcWrite = function(_buffer, _oldPrefix, _struct, _writeName, _value, _method)
    {
        var _prefix = _oldPrefix + "│    ";
        repeat(string_length(_writeName)) _prefix += " ";
        
        buffer_write(_buffer, buffer_text, _oldPrefix);
        buffer_write(_buffer, buffer_text, "├─ ");
        buffer_write(_buffer, buffer_text, _writeName);
        buffer_write(_buffer, buffer_text, ":");
        __GuiDebugStructureInner(_buffer, _prefix, _value, _method);
        buffer_write(_buffer, buffer_u8, 0x0a); // newline
    }
    
    static _funcWriteLast = function(_buffer, _oldPrefix, _struct, _writeName, _value, _method)
    {
        buffer_write(_buffer, buffer_text, _oldPrefix);
        buffer_write(_buffer, buffer_text, "╰─ ");
        buffer_write(_buffer, buffer_text, _writeName);
        buffer_write(_buffer, buffer_text, ":");
        
        var _prefix = _oldPrefix + "     ";
        repeat(string_length(_writeName)) _prefix += " ";
        __GuiDebugStructureInner(_buffer, _prefix, _value, _method);
    }
    
    
    
    if (is_handle(_value) && instance_exists(_value))
    {
        var _instance = _value;
        
        buffer_write(_buffer, buffer_text, object_get_name(_instance.object_index));
        buffer_write(_buffer, buffer_text, ":");
        buffer_write(_buffer, buffer_text, string(real(_instance)));
        
        var _nameArray = [];
        
        with(_instance)
        {
            _method(_nameArray);
        }
        
        if (array_length(_nameArray) > 0)
        {
            buffer_write(_buffer, buffer_text, "\n");
            
            var _i = 0;
            repeat((array_length(_nameArray) div 2) - 1)
            {
                _funcWrite(_buffer, _prefix, _instance, _nameArray[_i], _nameArray[_i+1], _method);
                _i += 2;
            }
            
            _funcWriteLast(_buffer, _prefix, _instance, _nameArray[_i], _nameArray[_i+1], _method);
        }
    }
    else if (is_struct(_value))
    {
        var _struct = _value;
        
        var _instanceOf = instanceof(_struct);
        if (_instanceOf == "struct")
        {
            buffer_write(_buffer, buffer_text, "{}");
        }
        else
        {
            buffer_write(_buffer, buffer_text, "{");
            buffer_write(_buffer, buffer_text, string(_instanceOf));
            buffer_write(_buffer, buffer_text, "}");
        }
        
        if (variable_struct_names_count(_struct) > 0)
        {
            buffer_write(_buffer, buffer_text, "\n");
            
            var _oldPrefix = _prefix;
            
            var _nameArray = variable_struct_get_names(_struct);
            array_sort(_nameArray, true);
            
            var _i = 0;
            repeat(array_length(_nameArray)-1)
            {
                var _name = _nameArray[_i];
                _funcWrite(_buffer, _prefix, _struct, _name, _name, _method);
                ++_i;
            }
            
            _funcWriteLast(_buffer, _prefix, _struct, _name, _name, _method);
        }
    }
    else if (is_array(_value))
    {
        if (array_length(_value) <= 0)
        {
            buffer_write(_buffer, buffer_text, "[]");
        }
        else
        {
            var _array = _value;
            
            buffer_write(_buffer, buffer_text, "[]\n");
            
            var _oldPrefix = _prefix;
            _prefix += "│  ";
            
            var _i = 0;
            repeat(array_length(_array)-1)
            {
                buffer_write(_buffer, buffer_text, _oldPrefix);
                buffer_write(_buffer, buffer_text, "├─");
                __GuiDebugStructureInner(_buffer, _prefix, _array[_i], _method);
                buffer_write(_buffer, buffer_u8, 0x0a); // newline
                ++_i;
            }
            
            _prefix = _oldPrefix + "   ";
            buffer_write(_buffer, buffer_text, _oldPrefix);
            buffer_write(_buffer, buffer_text, "╰─");
            __GuiDebugStructureInner(_buffer, _prefix, _array[_i], _method);
        }
    }
    else if (is_string(_value))
    {
        if (_value == "")
        {
            buffer_write(_buffer, buffer_text, " \"\"");
        }
        else
        {
            buffer_write(_buffer, buffer_text, " \"");
            buffer_write(_buffer, buffer_text, _value);
            buffer_write(_buffer, buffer_text, "\"");
        }
    }
    else
    {
        buffer_write(_buffer, buffer_text, " "); // space
        buffer_write(_buffer, buffer_text, string(_value));
    }
}

function __GuiDebugStructureASCIIInner(_buffer, _prefix, _value, _method)
{
    static _funcWrite = function(_buffer, _oldPrefix, _struct, _variableName, _writeName, _method)
    {
        var _prefix = _oldPrefix + "|    ";
        repeat(string_length(_writeName)) _prefix += " ";
        
        buffer_write(_buffer, buffer_text, _oldPrefix);
        buffer_write(_buffer, buffer_text, "|- ");
        buffer_write(_buffer, buffer_text, _writeName);
        buffer_write(_buffer, buffer_text, ":");
        __GuiDebugStructureASCIIInner(_buffer, _prefix, _struct[$ _variableName], _method);
        buffer_write(_buffer, buffer_u8, 0x0a); // newline
    }
    
    static _funcWriteLast = function(_buffer, _oldPrefix, _struct, _variableName, _writeName, _method)
    {
        buffer_write(_buffer, buffer_text, _oldPrefix);
        buffer_write(_buffer, buffer_text, "\\- ");
        buffer_write(_buffer, buffer_text, _writeName);
        buffer_write(_buffer, buffer_text, ":");
        
        var _prefix = _oldPrefix + "     ";
        repeat(string_length(_writeName)) _prefix += " ";
        __GuiDebugStructureASCIIInner(_buffer, _prefix, _struct[$ _variableName], _method);
    }
    
    
    
    if (is_handle(_value) && instance_exists(_value))
    {
        var _instance = _value;
        
        buffer_write(_buffer, buffer_text, object_get_name(_instance.object_index));
        buffer_write(_buffer, buffer_text, ":");
        buffer_write(_buffer, buffer_text, string(real(_instance)));
        
        var _nameArray = [];
        
        with(_instance)
        {
            _method(_nameArray);
        }
        
        if (array_length(_nameArray) > 0)
        {
            buffer_write(_buffer, buffer_text, "\n");
            
            var _i = 0;
            repeat((array_length(_nameArray) div 2) - 1)
            {
                _funcWrite(_buffer, _prefix, _instance, _nameArray[_i], _nameArray[_i+1], _method);
                _i += 2;
            }
            
            _funcWriteLast(_buffer, _prefix, _instance, _nameArray[_i], _nameArray[_i+1], _method);
        }
    }
    else if (is_struct(_value))
    {
        var _struct = _value;
        
        var _instanceOf = instanceof(_struct);
        if (_instanceOf == "struct")
        {
            buffer_write(_buffer, buffer_text, "{}");
        }
        else
        {
            buffer_write(_buffer, buffer_text, "{");
            buffer_write(_buffer, buffer_text, string(_instanceOf));
            buffer_write(_buffer, buffer_text, "}");
        }
        
        if (variable_struct_names_count(_value) > 0)
        {
            buffer_write(_buffer, buffer_text, "\n");
            
            var _oldPrefix = _prefix;
            
            var _nameArray = variable_struct_get_names(_struct);
            array_sort(_nameArray, true);
            
            var _i = 0;
            repeat(array_length(_nameArray)-1)
            {
                var _name = _nameArray[_i];
                _funcWrite(_buffer, _prefix, _struct, _name, _name, _method);
                ++_i;
            }
            
            _funcWriteLast(_buffer, _prefix, _struct, _name, _name, _method);
        }
    }
    else if (is_array(_value))
    {
        if (array_length(_value) <= 0)
        {
            buffer_write(_buffer, buffer_text, "[]");
        }
        else
        {
            buffer_write(_buffer, buffer_text, "[]\n");
            
            var _oldPrefix = _prefix;
            _prefix += "|  ";
            
            var _array = _value;
            var _i = 0;
            repeat(array_length(_array)-1)
            {
                buffer_write(_buffer, buffer_text, _oldPrefix);
                buffer_write(_buffer, buffer_text, "|-");
                __GuiDebugStructureASCIIInner(_buffer, _prefix, _array[_i], _method);
                buffer_write(_buffer, buffer_text, "\n");
                ++_i;
            }
            
            buffer_write(_buffer, buffer_text, _oldPrefix);
            _prefix = _oldPrefix + "   ";
            
            buffer_write(_buffer, buffer_text, "\\-");
            __GuiDebugStructureASCIIInner(_buffer, _prefix, _array[_i], _method);
        }
    }
    else if (is_string(_value))
    {
        if (_value == "")
        {
            buffer_write(_buffer, buffer_text, " \"\"");
        }
        else
        {
            buffer_write(_buffer, buffer_text, " \"");
            buffer_write(_buffer, buffer_text, _value);
            buffer_write(_buffer, buffer_text, "\"");
        }
    }
    else
    {
        buffer_write(_buffer, buffer_text, " ");
        buffer_write(_buffer, buffer_text, string(_value));
    }
}
