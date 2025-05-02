// Feather disable all

/// Sets the priority of an instance to be above (greater than) a sibling instance.
/// 
/// @param sibling
/// @param [instance=self]
/// @param [delta=1]

function GuiSetPriorityAbove(_sibling, _instance = self, _delta = 1)
{
    if (not GUI_EXISTS(_instance)) return;
    
    var _parent = _instance.GUI_VARS.__parent;
    if (not GUI_EXISTS(_parent)) return;
    
    GuiSetPriority(GUI_EXISTS(_sibling)? (_sibling.__priority + _delta) : 0, _instance);
}