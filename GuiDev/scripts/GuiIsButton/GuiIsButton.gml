// Feather disable all

/// Returns whether an instance has the `GUI_BEHAVIOR_BUTTON` behavior, as set by ``GuiSetBehavior()`.
/// 
/// @param [instance=self]

function GuiIsButton(_instance = self)
{
    return (GuiGetBehavior(_instance) == GUI_BEHAVIOR_BUTTON);
}