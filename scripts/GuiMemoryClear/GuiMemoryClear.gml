// Feather disable all

/// @param key
/// @param [key]

function GuiMemoryClear()
{
    static _memoryStruct = __GuiSystem().__memoryStruct;
    
    var _i;
    repeat(argument_count-1)
    {
        _memoryStruct = _memoryStruct[$ argument[_i]];
        if (not is_struct(_memoryStruct)) return;
        
        ++_i;
    }
    
    struct_remove(_memoryStruct, argument[argument_count-1]);
}