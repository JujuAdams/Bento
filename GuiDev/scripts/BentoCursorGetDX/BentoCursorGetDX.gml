// Feather disable all

/// Returns how far the cursor has moved between two update frames:
/// 
/// - If the navigation mode is set to `GUI_MODE_MOUSE` or `GUI_MODE_TOUCH` then this function
///   returns the interframe x-axis distance.
/// 
/// - If the navigation mode is set to `GUI_MODE_KEYBOARD` or `GUI_MODE_GAMEPAD` then this function
///   returns the `dX` value set by `BentoInputDirectional()`.
/// 
/// @param [layer=current]

function BentoCursorGetDX(_layer = undefined)
{
    static _system = __BentoSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        if (__navPointer)
        {
            return __mouseHold? (__mouseX - __mousePrevX) : 0;
        }
        else if (__navDirectional)
        {
            return __directionalStateX.__output;
        }
    }
    
    return 0;
}