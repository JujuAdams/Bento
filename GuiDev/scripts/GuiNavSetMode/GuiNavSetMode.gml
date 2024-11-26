// Feather disable all

/// Sets the current navigation mode. This should be one of the following constants:
/// 
/// - `GUI_NAV_UNKNOWN`
/// - `GUI_NAV_MOUSE`
/// - `GUI_NAV_DIRECTIONAL`
/// - `GUI_NAV_TOUCH`
/// 
/// @param mode

function GuiNavSetMode(_mode)
{
    static _system = __GuiSystem();
    
    with(_system)
    {
        if (_mode == GUI_NAV_DIRECTIONAL)
        {
            if (__navPointer)
            {
                //Reset mouse variables
                __mouseHold = false;
                
                __directionalLastX = __mouseX;
                __directionalLastY = __mouseY;
                __mousePrevX   = __mouseX;
                __mousePrevY   = __mouseY;
                __mousePressX  = undefined;
                __mousePressY  = undefined;
            }
        }
        else
        {
            GuiNavClearFocus();
        }
        
        __navMode = _mode;
        __navPointer = ((_mode == GUI_NAV_MOUSE) || (_mode == GUI_NAV_TOUCH));
    }
}