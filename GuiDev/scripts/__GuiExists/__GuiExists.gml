// Feather disable all

/// @param target

function __GuiExists(_target)
{
    if (instance_exists(_target)) return true;
    if (is_handle(_target) || is_method(_target)) return false;
    return is_struct(_target);
}