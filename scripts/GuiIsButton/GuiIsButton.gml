// Feather disable all

/// @param instance

function GuiIsButton(_instance)
{
    return (GuiGetBehavior(_instance) == GUI_BEHAVIOR_BUTTON);
}