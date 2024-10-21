// Feather disable all

/// Returns whether an instance has been marked as "animating" by `GuiAnimStart()`.
/// 
/// @param [instance=id]

function GuiAnimGet(_instance = id)
{
    return instance_exists(_instance)? _instance.__animating : false;
}