// Feather disable all

/// @param [instance=id]

function GuiIsButton(_instance = id)
{
    return (GuiGetBehavior(_instance) == GUI_BEHAVIOR_BUTTON);
}