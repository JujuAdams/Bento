// Feather disable all

/// Returns the y-coordinate of the cursor's position.
/// 
/// @param [layer=current]

function GuiNavGetCursorY(_layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
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