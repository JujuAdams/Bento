// Feather disable all

/// Returns how far the cursor has moved between the most recent call to `BentoSystemStep()` and
/// and the call before that.
/// 
/// - If the input mode is set to `BENTO_MODE_MOUSE` or `BENTO_MODE_TOUCH` then this function
///   returns the interframe y-axis distance.
/// 
/// - If the input mode is set to `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD` then this function
///   returns the `dY` value set by `BentoInputDirectional()`.
/// 
/// @param [directionalThreshold=0.001]
/// @param [layerOrName=current]

function BentoCursorGetDY(_directionalThreshold = 0.001, _layerOrName = undefined)
{
    with(__BentoLayerEnsure(_layerOrName))
    {
        if (__navPointer)
        {
            return __mouseHold? (__mouseY - __mousePrevY) : 0;
        }
        else if (__navDirectional)
        {
            var _output = __turboState.__outputY;
            return (abs(_output) < _directionalThreshold)? 0 : _output;
        }
    }
    
    return 0;
}