// Feather disable all

/// @param [instance=self]

function GuiGetVisible(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return false;
    
    return _instance.GUI_VARS.__visible;
}