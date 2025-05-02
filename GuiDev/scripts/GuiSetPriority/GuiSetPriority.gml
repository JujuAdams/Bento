// Feather disable all

/// Sets the priority for an instance.
/// 
/// @param priority
/// @param [instance=id]

function GuiSetPriority(_priority, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
    {
        if (_priority == __priority) return;
        __priority = _priority;
        
        __environment.__layoutDirty = true;
        __environment.__stepDirty   = true;
        __environment.__drawDirty   = true;
        
        __GuiMarkChildOrderDirty(__parent);
    }
}