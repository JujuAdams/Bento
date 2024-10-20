// Feather disable all

function GuiMemoryClearAll()
{
    static _memoryStruct = __GuiSystem().__memoryStruct;
    
    var _namesArray = struct_get_names(_memoryStruct);
    var _i = 0;
    repeat(array_length(_namesArray))
    {
        struct_remove(_memoryStruct, _namesArray[_i]);
        ++_i;
    }
}