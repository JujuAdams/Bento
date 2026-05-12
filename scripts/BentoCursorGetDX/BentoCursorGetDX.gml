// Feather disable all

/// Returns how far the cursor has moved between the most recent call to `BentoSystemStep()` and
/// and the call before that.
/// 
/// - If the input mode is set to `BENTO_MODE_MOUSE` or `BENTO_MODE_TOUCH` then this function
///   returns the interframe x-axis distance.
/// 
/// - If the input mode is set to `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD` then this function
///   returns the `dX` value set by `BentoInputNavigation()`.
/// 
/// @param [navigationThreshold=0.001]
/// @param [layerOrName=current]

function BentoCursorGetDX(_navigationThreshold = 0.001, _layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if (__inputModePointer)
        {
            return (__pointerPrimaryState & __BENTO_STATE_START)? (__pointerX - __pointerPrevX) : 0;
        }
        else if (__inputModeNavigation)
        {
            var _output = __turboState.__outputX;
            return (abs(_output) < _navigationThreshold)? 0 : _output;
        }
    }
    
    return 0;
}