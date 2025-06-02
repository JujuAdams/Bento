// Feather disable all

/// @param [element=self]

function GuiGetIndex(_element = self)
{
    var _parent = GuiGetParent(1, _element);
    if (not GuiExists(_parent)) return undefined;
    
    var _index = array_get_index(_parent.GUI_VARS.__childArray, _element);
    return (_index < 0)? undefined : _index;
}