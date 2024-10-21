// Feather disable all

/// Reads a memory value that has already been set. The `key` parameter(s) will be stringified
/// automatically. If that memory value cannot be found, then this function will return `undefined`.
/// 
/// @param key
/// @param [key]

function GuiMemoryRead()
{
    static _memoryStruct = __GuiSystem().__memoryStruct;
    
    if (argument_count <= 0)
    {
        return _memoryStruct;
    }
    
    var _i;
    repeat(argument_count-1)
    {
        var _key = argument[_i];
        
        if (variable_struct_exists(_memoryStruct, _key))
        {
            _memoryStruct = _memoryStruct[$ _key];
            if (not is_struct(_memoryStruct))
            {
                __GuiError("");
            }
        }
        else
        {
            return undefined;
        }
        
        ++_i;
    }
    
    return _memoryStruct[$ argument[argument_count-1]];
}