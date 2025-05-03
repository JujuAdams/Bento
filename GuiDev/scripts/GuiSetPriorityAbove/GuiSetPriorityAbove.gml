// Feather disable all

/// Sets the priority of an instance to be above (greater than) a sibling instance.
/// 
/// @param sibling
/// @param [element=self]
/// @param [delta=1]

function GuiSetPriorityAbove(_sibling, _element = self, _delta = 1)
{
    if (not GUI_EXISTS(_element)) return;
    
    var _parent = _element.GUI_VARS.__parent;
    if (not GUI_EXISTS(_parent)) return;
    
    GuiSetPriority(GUI_EXISTS(_sibling)? (_sibling.__priority + _delta) : 0, _element);
}