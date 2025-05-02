// Feather disable all

/// Returns the `id` of the instance with a matching name. If no instance exists, this function
/// will return `noone`.
/// 
/// @param name

function GuiNameFind(_name)
{
    return (GUI_ENVIRONMENT.__nameMap[? _name] ?? noone);
}