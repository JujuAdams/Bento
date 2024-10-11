// Feather disable all

function GuiNavGetDY()
{
    static _system = __GuiSystem();
    with(_system)
    {
        if (__navPointer)
        {
            return __mouseHold? (__mouseY - __mousePrevY) : 0;
        }
        else if (__navMode == GUI_NAV_GAMEPAD)
        {
            return __gamepadDY;
        }
    }
    
    return 0;
}