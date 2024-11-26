// Feather disable all

/// Returns how far the cursor has moved between two update frames:
/// 
/// - If the navigation mode is set to `GUI_NAV_MOUSE` or `GUI_NAV_TOUCH` then this function
///   returns the interframe y-axis distance.
/// 
/// - If the navigation mode is set to `GUI_NAV_DIRECTIONAL` then this function returns the `dY` value
///   set by `GuiInputDirectional()`.

function GuiNavGetDY()
{
    static _system = __GuiSystem();
    with(_system)
    {
        if (__navPointer)
        {
            return __mouseHold? (__mouseY - __mousePrevY) : 0;
        }
        else if (__navMode == GUI_NAV_DIRECTIONAL)
        {
            return __directionalStateY.__output;
        }
    }
    
    return 0;
}