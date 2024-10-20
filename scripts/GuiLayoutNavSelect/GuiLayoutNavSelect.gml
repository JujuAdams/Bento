// Feather disable all

/// @param layout
/// @param index

function GuiLayoutNavSelect(_layout, _index)
{
    var _array = _layout.__instanceArray;
    
    if ((_index < 0) || (_index >= array_length(_array))) return;
    
    GuiNavSelect(_array[_index]);
}