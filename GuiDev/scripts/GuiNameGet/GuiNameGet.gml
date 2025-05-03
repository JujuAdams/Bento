// Feather disable all

/// Returns the name of an instance, as set by `GuiNameSet()`.
/// 
/// @param [element=self]

function GuiNameGet(_element = self)
{
    if (not __GuiExists(_element)) return undefined;
    
    return _element.GUI_VARS.__name;
}