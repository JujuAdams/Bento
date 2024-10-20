// Feather disable all

/// @param value
/// @param key
/// @param [key]

function GuiMemoryWrite()
{
    static _memoryStruct = __GuiSystem().__memoryStruct;
    
    var _value = argument[0];
    
    var _i;
    repeat(argument_count-2)
    {
        var _key = argument[_i];
        
        if (variable_struct_exists(_memoryStruct, _key))
        {
            _memoryStruct = _memoryStruct[$ _key];
            if (not is_struct(_memoryStruct))
            {
                __GuiError($"Key \"{_key}\" already exists and is not a struct");
            }
        }
        else
        {
            var _newStruct = {};
            _memoryStruct[$ _key] = _newStruct;
            _memoryStruct = _newStruct;
        }
        
        ++_i;
    }
    
    _memoryStruct[$ _key] = _value;
}