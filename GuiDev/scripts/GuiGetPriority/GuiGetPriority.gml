// Feather disable all

/// Returns the priority for an instance.
/// 
/// @param [instance=self]

function GuiGetPriority(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return 0;
    
    return _instance.GUI_VARS.__priority;
}