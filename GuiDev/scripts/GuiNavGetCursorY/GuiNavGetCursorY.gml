// Feather disable all

/// Returns the y-coordinate of the cursor's position.

function GuiNavGetCursorY()
{
    with(GUI_ENVIRONMENT)
    {
        if (__navMode == GUI_NAV_MOUSE)
        {
            return __mouseY;
        }
        else if (__navMode == GUI_NAV_DIRECTIONAL)
        {
            return __directionalLastY;
        }
        else if (__navMode == GUI_NAV_TOUCH)
        {
            return __mouseHold? __mouseY : __mousePrevY;
        }
        else
        {
            return 0;
        }
    }
}