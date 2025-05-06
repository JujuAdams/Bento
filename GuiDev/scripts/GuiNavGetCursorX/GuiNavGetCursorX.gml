// Feather disable all

/// Returns the x-coordinate of the cursor's position.
/// 
/// @param [layer=current]

function GuiNavGetCursorX(_layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        if (__navMode == GUI_NAV_MOUSE)
        {
            return __mouseX;
        }
        else if (__navDirectional)
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