// Feather disable all

/// Sets input values for navigation input (gamepad and keyboard). The `primaryAction` argument
/// should be set to the current held state of the primary "accept" or "confirm" button,
/// conventionally the "A" button on a gamepad or the spacebar on a keyboard.
/// 
/// The `threshold` parameter for this function filters out small inputs which are commonly sent
/// by noisy gamepad thumbsticks. The default value of `0.25` will eliminate most erroneous
/// inputs. If you're already filtering thumbstick input or are using a third-party library (such
/// as Input `https://offalynne.github.io/Input/`) then you will want to set `threshold` to `0`.
/// 
/// @param dX
/// @param dY
/// @param primaryAction
/// @param [threshold=0.25]

function BentoInputNavigation(_dX, _dY, _primaryAction, _threshold = 0.25)
{
    static _system = __BentoSystem();
    with(_system.__environmentCurrent)
    {
        if (sqrt(_dX*_dX + _dY*_dY) < _threshold)
        {
            _dX = 0;
            _dY = 0;
        }
        
        __envNavigationDX   = _dX;
        __envNavigationDY   = _dY;
        __envNavigationHold = _primaryAction;
    }
}