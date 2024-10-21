// Feather disable all

/// Returns whether an instance has the `GUI_BEHAVIOR_BUTTON` behavior, as set by ``GuiSetBehavior()`.
/// 
/// @param [instance=id]

function GuiIsButton(_instance = id)
{
    return (GuiGetBehavior(_instance) == GUI_BEHAVIOR_BUTTON);
}