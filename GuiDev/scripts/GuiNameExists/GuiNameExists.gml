// Feather disable all

/// Returns whether an instance with the given name exists.
/// 
/// @param name

function GuiNameExists(_name)
{
    return instance_exists(GUI_ENVIRONMENT.__nameMap[? _name] ?? noone);
}