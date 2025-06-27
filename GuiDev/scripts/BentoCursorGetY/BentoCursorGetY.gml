// Feather disable all

/// Returns the y-coordinate of the cursor's position.
/// 
/// @param [layer=current]

function BentoCursorGetY(_layer = undefined)
{
    static _system = __BentoSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        if (__navMode == GUI_MODE_MOUSE)
        {
            return __mouseY;
        }
        else if (__navDirectional)
        {
            return 0.5*(__cursorLastT + __cursorLastB);
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