// Feather disable all

/// Sets the priority of an instance to be above (greater than) a sibling instance.
/// 
/// @param sibling
/// @param [element=self]
/// @param [delta=1]

function GuiSetPriorityAbove(_sibling, _element = self, _delta = 1)
{
    if (not __GuiExists(_element)) return;
    
    var _parent = _element.GUI_VARS.__parent;
    if (not __GuiExists(_parent)) return;
    
    GuiSetPriority(__GuiExists(_sibling)? (_sibling.__priority + _delta) : 0, _element);
}