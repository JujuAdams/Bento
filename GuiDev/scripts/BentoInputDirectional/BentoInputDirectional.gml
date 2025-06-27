// Feather disable all

/// Sets input values for directional input (gamepad and keyboard). The `primaryAction` argument
/// should be set to the current held state of the primary "accept" or "confirm" button,
/// conventionally the "A" button on a gamepad or the spacebar on a keyboard.
/// 
/// @param dX
/// @param dY
/// @param primaryAction

function BentoInputDirectional(_dX, _dY, _primaryAction)
{
    static _system = __BentoSystem();
    with(_system.__environmentCurrent)
    {
        __envDirectionalDX   = _dX;
        __envDirectionalDY   = _dY;
        __envDirectionalHold = _primaryAction;
    }
}