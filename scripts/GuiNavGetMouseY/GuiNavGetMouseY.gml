// Feather disable all

function GuiNavGetMouseY()
{
    static _system = __GuiSystem();
    
    with(_system)
    {
        if (__navMode == GUI_NAV_MOUSE)
        {
            return __mouseY;
        }
        else if (__navMode == GUI_NAV_GAMEPAD)
        {
            return __gamepadLastY;
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