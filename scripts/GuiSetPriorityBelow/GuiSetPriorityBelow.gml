// Feather disable all

/// @param instance
/// @param sibling
/// @param [delta=1]

function GuiSetPriorityBelow(_instance, _sibling, _delta = 1)
{
    if (not instance_exists(_instance)) return;
    
    var _parent = _instance.__parent;
    if (not instance_exists(_parent)) return;
    
    GuiSetPriority(_instance, instance_exists(_sibling)? (_sibling.priority - _delta) : 0);
}