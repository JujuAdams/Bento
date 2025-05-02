// Feather disable all

/// Returns the y-coordinate of the cursor's position.
/// 
/// @param [environment=current]

function GuiNavGetCursorY(_environment = undefined)
{
    static _system = __GuiSystem();
    
    with(_environment ?? _system.__environmentCurrent)
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