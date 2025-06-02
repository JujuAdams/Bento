// Feather disable all

/// Sets the local depth of an instance to be below (numerically greater than) a sibling instance.
/// 
/// @param sibling
/// @param [element=self]
/// @param [delta=1]

function GuiSetDepthBelow(_sibling, _element = self, _delta = 1)
{
    if (not GuiExists(_element)) return;
    
    var _parent = _element.GUI_VARS.__parent;
    if (not GuiExists(_parent)) return;
    
    GuiSetDepth(GuiExists(_sibling)? (_sibling.__drawDepth + _delta) : 0, _element);
}