// Feather disable all

/// @param instance
/// @param name

function GuiNameSetSingleton(_instance, _name)
{
    GuiDestroyByName(_name);
    GuiSetName(_instance, _name);
}