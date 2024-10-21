// Feather disable all

/// Destroys an instance with a matching name, if it exists.
/// 
/// @param name

function GuiNameDestroy(_name)
{
    GuiDestroy(GuiNameFind(_name));
}