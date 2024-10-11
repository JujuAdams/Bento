// Feather disable all

/// @param layout
/// @param [index=0]

function GuiLayoutNavSelect(_layout, _index = 0)
{
    var _array = _layout.__instanceArray;
    
    if ((_index < 0) || (_index >= array_length(_array))) return;
    
    GuiNavSelect(_array[_index]);
}