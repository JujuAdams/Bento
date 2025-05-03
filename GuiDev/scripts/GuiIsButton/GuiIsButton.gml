// Feather disable all

/// Returns whether an instance has the `GUI_BEHAVIOR_BUTTON` behavior, as set by ``GuiSetBehavior()`.
/// 
/// @param [element=self]

function GuiIsButton(_element = self)
{
    return (GuiGetBehavior(_element) == GUI_BEHAVIOR_BUTTON);
}