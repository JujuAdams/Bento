// Feather disable all

/// Sets the priority for an instance.
/// 
/// @param priority
/// @param [instance=id]

function GuiSetPriority(_priority, _instance = id)
{
    static _system          = __GuiSystem();
    static _dirtyOrderArray = __GuiSystem().__dirtyOrderArray;
    
    if (not instance_exists(_instance)) return;
    if (_priority == _instance.priority) return;
    
    _system.__stepDirty = true;
    _system.__drawDirty = true;
    
    _instance.priority = _priority;
    
    with(_instance.__parent)
    {
        if (not __orderDirty)
        {
            __orderDirty = true;
            array_push(_dirtyOrderArray, id);
        }
    }
}