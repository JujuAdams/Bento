// Feather disable all

/// Returns the name of an instance, as set by `GuiNameSet()`.
/// 
/// @param [instance=self]

function GuiNameGet(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return undefined;
    
    return _instance.GUI_VARS.__name;
}