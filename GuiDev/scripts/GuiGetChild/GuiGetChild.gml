// Feather disable all

/// @param index
/// @param [parent=self]

function GuiGetChild(_index, _parent = self)
{
    if ((_index < 0) || (not GuiExists(_parent))) return undefined;
    
    var _array = _parent.GUI_VARS.__childArray;
    if (array_length(_array) >= _index) return undefined;
    
    return _array[_index];
}