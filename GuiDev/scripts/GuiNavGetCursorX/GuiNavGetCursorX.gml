// Feather disable all

/// Returns the x-coordinate of the cursor's position.
/// 
/// @param [environment=current]

function GuiNavGetCursorX(_environment = undefined)
{
    static _system = __GuiSystem();
    
    with(_environment ?? _system.__environmentCurrent)
    {
        if (__navMode == GUI_NAV_MOUSE)
        {
            return __mouseX;
        }
        else if (__navMode == GUI_NAV_DIRECTIONAL)
        {
            return __directionalLastX;
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