// Feather disable all

/// Returns the x-coordinate of the cursor's position.

function GuiNavGetCursorX()
{
    with(GUI_ENVIRONMENT)
    {
        if (__navMode == GUI_NAV_MOUSE)
        {
            return __mouseX;
        }
        else if (__navMode == GUI_NAV_DIRECTIONAL)
        {
            return __directionalLastX;
        }
        else if (__navMode == GUI_NAV_TOUCH)
        {
            return __mouseHold? __mouseX : __mousePrevX;
        }
        else
        {
            return 0;
        }
    }
}