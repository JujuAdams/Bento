// Feather disable all

/// Returns the x-coordinate of the cursor's position.
/// 
/// @param [layer=current]

function GuiCursorGetX(_layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        if (__navMode == GUI_MODE_MOUSE)
        {
            return __mouseX;
        }
        else if (__navDirectional)
        {
            return __directionalLastX;
        }
        else if (__navMode == GUI_MODE_TOUCH)
        {
            return __mouseHold? __mouseX : __mousePrevX;
        }
        else
        {
            return 0;
        }
    }
}