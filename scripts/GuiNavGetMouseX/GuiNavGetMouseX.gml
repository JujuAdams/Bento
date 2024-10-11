// Feather disable all

function GuiNavGetMouseX()
{
    static _system = __GuiSystem();
    
    with(_system)
    {
        if (__navMode == GUI_NAV_MOUSE)
        {
            return __mouseX;
        }
        else if (__navMode == GUI_NAV_GAMEPAD)
        {
            return __gamepadLastX;
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