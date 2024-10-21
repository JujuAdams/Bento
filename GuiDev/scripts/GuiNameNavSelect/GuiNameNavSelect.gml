// Feather disable all

/// Selects the instance with a mathcing name for navigation.
/// 
/// @param name

function GuiNameNavSelect(_name)
{
    return GuiNavSelect(GuiNameFind(_name));
}