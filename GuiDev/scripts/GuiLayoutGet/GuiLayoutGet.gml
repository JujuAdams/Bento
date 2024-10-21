// Feather disable all

/// Returns the Nth instance in a layout. If that instance doesn't exist this function will return
/// `noone`.
/// 
/// @param layout
/// @param index

function GuiLayoutGet(_layout, _index)
{
    var _array = _layout.__instanceArray;
    
    if ((_index < 0) || (_index >= array_length(_array))) return noone;
    
    return _array[_index];
}