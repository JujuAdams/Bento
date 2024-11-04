// Feather disable all

/// Returns how far the cursor has moved between two update frames:
/// 
/// - If the navigation mode is set to `GUI_NAV_MOUSE` or `GUI_NAV_TOUCH` then this function
///   returns the interframe x-axis distance.
/// 
/// - If the navigation mode is set to `GUI_NAV_GAMEPAD` then this function returns the `dX` value
///   set by `GuiInputGamepad()`.

function GuiNavGetDX()
{
    static _system = __GuiSystem();
    with(_system)
    {
        if (__navPointer)
        {
            return __mouseHold? (__mouseX - __mousePrevX) : 0;
        }
        else if (__navMode == GUI_NAV_GAMEPAD)
        {
            return __gamepadStateX.__output;
        }
    }
    
    return 0;
}