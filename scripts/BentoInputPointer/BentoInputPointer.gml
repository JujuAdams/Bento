// Feather disable all

/// Sets input values for pointer input (mouse and/or touch). The `primaryAction` argument should
/// be set to the current held state of the primary "accept" or "confirm" button, conventionally
/// the left mouse button (e.g. `device_mouse_check_button(0, mb_left)`).
/// 
/// @param x
/// @param y
/// @param primaryAction

function BentoInputPointer(_x, _y, _primaryAction)
{
    static _system = __BentoSystem();
    with(_system.__environmentCurrent)
    {
        __envMouseX    = _x / _system.__globalScale;
        __envMouseY    = _y / _system.__globalScale;
        __envMouseHold = _primaryAction;
    }
}