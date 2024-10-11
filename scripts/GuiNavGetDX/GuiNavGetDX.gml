// Feather disable all

function GuiNavGetDX()
{
    static _system = __GuiSystem();
    with(_system)
    {
        if (__navPointer)
        {
            return __mouseHold? (__mouseX - __mousePrevX) : 0;
        }
        else if (__navMode == GUI_NAV_GAMEPAD)
        {
            return __gamepadDX;
        }
    }
    
    return 0;
}