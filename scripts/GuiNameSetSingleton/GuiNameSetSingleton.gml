// Feather disable all

/// @param instance
/// @param name

function GuiNameSetSingleton(_instance, _name)
{
    GuiNameDestroy(_name);
    GuiNameSet(_instance, _name);
}