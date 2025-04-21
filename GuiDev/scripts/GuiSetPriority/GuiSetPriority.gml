// Feather disable all

/// Sets the priority for an instance.
/// 
/// @param priority
/// @param [instance=id]

function GuiSetPriority(_priority, _instance = id)
{
    static _system = __GuiSystem();
    static _dirtyChildOrderArray = __GuiSystem().__dirtyChildOrderArray;
    
    if (not instance_exists(_instance)) return;
    if (_priority == _instance.__priority) return;
    
    _system.__layoutDirty = true;
    _system.__stepDirty   = true;
    _system.__drawDirty   = true;
    
    _instance.__priority = _priority;
    
    __GuiMarkChildOrderDirty(_instance.__parent);
}