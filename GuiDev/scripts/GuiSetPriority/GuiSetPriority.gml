// Feather disable all

/// Sets the priority for an instance.
/// 
/// @param priority
/// @param [element=self]

function GuiSetPriority(_priority, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (_priority == __priority) return;
        __priority = _priority;
        
        __layer.__layoutDirty = true;
        __layer.__stepDirty   = true;
        __layer.__drawDirty   = true;
        
        __GuiMarkChildOrderDirty(__parent);
    }
}