// Feather disable all

/// Sets input values for pointer input (mouse and/or touch). The `primaryAction` argument should
/// be set to the current held state of the primary "accept" or "confirm" button, conventionally
/// the left mouse button (e.g. `device_mouse_check_button(0, mb_left)`).
/// 
/// @param x
/// @param y
/// @param primaryAction

function GuiInputPointer(_x, _y, _buttonHold)
{
    static _system = __GuiSystem();
    
    with(_system)
    {
        if (__navPointer)
        {
            __mousePrevHold = __mouseHold;
            
            if (__mousePrevHold)
            {
                __mousePrevX = __mouseX;
                __mousePrevY = __mouseY;
            }
            
            __mouseHold = _buttonHold;
            
            if ((__navMode == GUI_NAV_TOUCH) && (not _buttonHold))
            {
                __mouseX = -__GUI_VERY_LARGE;
                __mouseY = -__GUI_VERY_LARGE;
            }
            else
            {
                __mouseX = _x;
                __mouseY = _y;
            }
        }
    }
}