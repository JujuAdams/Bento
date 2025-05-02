// Feather disable all

/// Returns whether the navigation mode has been set to `GUI_NAV_TOUCH`.

function GuiNavUsingTouch()
{
    return (GUI_ENVIRONMENT.__navMode == GUI_NAV_TOUCH);
}