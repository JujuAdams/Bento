// Feather disable all

/// Sets input values for directional input (gamepad and keyboard). The `primaryAction` argument
/// should be set to the current held state of the primary "accept" or "confirm" button,
/// conventionally the "A" button on a gamepad or the spacebar on a keyboard.
/// 
/// @param dX
/// @param dY
/// @param primaryAction

function GuiInputGamepad(_dX, _dY, _buttonHold)
{
    static _system = __GuiSystem();
    
    with(_system)
    {
        __gamepadPrevHold = __gamepadHold;
        
        __gamepadDX   = _dX;
        __gamepadDY   = _dY;
        __gamepadHold = _buttonHold;
    }
}