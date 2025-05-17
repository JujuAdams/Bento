// Feather disable all

/// Returns how far the cursor has moved between two update frames:
/// 
/// - If the navigation mode is set to `GUI_MODE_MOUSE` or `GUI_MODE_TOUCH` then this function
///   returns the interframe y-axis distance.
/// 
/// - If the navigation mode is set to `GUI_MODE_KEYBOARD` or `GUI_MODE_GAMEPAD` then this function
///   returns the `dY` value set by `GuiInputDirectional()`.
/// 
/// @param [layer=current]

function GuiCursorGetDY(_layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        if (__navPointer)
        {
            return __mouseHold? (__mouseY - __mousePrevY) : 0;
        }
        else if (__navDirectional)
        {
            return __directionalStateY.__output;
        }
    }
    
    return 0;
}