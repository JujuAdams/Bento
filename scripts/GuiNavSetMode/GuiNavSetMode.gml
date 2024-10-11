// Feather disable all

/// @param mode

function GuiNavSetMode(_mode)
{
    static _system = __GuiSystem();
    
    with(_system)
    {
        if (_mode == GUI_NAV_GAMEPAD)
        {
            if (__navPointer)
            {
                //Reset mouse variables
                __mouseHold = false;
                
                __gamepadLastX = __mouseX;
                __gamepadLastY = __mouseY;
                __mousePrevX   = __mouseX;
                __mousePrevY   = __mouseY;
                __mousePressX  = undefined;
                __mousePressY  = undefined;
            }
        }
        
        __navMode = _mode;
        __navPointer = ((_mode == GUI_NAV_MOUSE) || (_mode == GUI_NAV_TOUCH));
    }
}