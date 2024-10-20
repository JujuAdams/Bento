// Feather disable all

/// @param x
/// @param y
/// @param buttonHold

function GuiInputMouseAndTouch(_x, _y, _buttonHold)
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