// Feather disable all

/// Sets the priority for an instance.
/// 
/// @param priority
/// @param [instance=self]

function GuiSetPriority(_priority, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (_priority == __priority) return;
        __priority = _priority;
        
        __layer.__layoutDirty = true;
        __layer.__stepDirty   = true;
        __layer.__drawDirty   = true;
        
        __GuiMarkChildOrderDirty(__parent);
    }
}