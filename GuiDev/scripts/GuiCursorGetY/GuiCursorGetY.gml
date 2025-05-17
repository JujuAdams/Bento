// Feather disable all

/// Returns the y-coordinate of the cursor's position.
/// 
/// @param [layer=current]

function GuiCursorGetY(_layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        if (__navMode == GUI_MODE_MOUSE)
        {
            return __mouseY;
        }
        else if (__navDirectional)
        {
            return __directionalLastY;
        }
        else if (__navMode == GUI_MODE_TOUCH)
        {
            return __mouseHold? __mouseY : __mousePrevY;
        }
        else
        {
            return 0;
        }
    }
}