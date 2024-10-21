// Feather disable all

/// Sets the priority of an instance to be above (greater than) a sibling instance.
/// 
/// @param sibling
/// @param [instance=id]
/// @param [delta=1]

function GuiSetPriorityAbove(_sibling, _instance = id, _delta = 1)
{
    if (not instance_exists(_instance)) return;
    
    var _parent = _instance.__parent;
    if (not instance_exists(_parent)) return;
    
    GuiSetPriority(instance_exists(_sibling)? (_sibling.priority + _delta) : 0, _instance);
}