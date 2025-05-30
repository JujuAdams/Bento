// Feather disable all

/// Sets the priority of an instance to be below (less than) a sibling instance.
/// 
/// @param sibling
/// @param [element=self]
/// @param [delta=1]

function GuiSetPriorityBelow(_sibling, _element = self, _delta = 1)
{
    if (not GuiExists(_element)) return;
    
    var _parent = _element.GUI_VARS.__parent;
    if (not GuiExists(_parent)) return;
    
    GuiSetPriority(GuiExists(_sibling)? (_sibling.__priority - _delta) : 0, _element);
}