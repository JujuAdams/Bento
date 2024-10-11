// Feather disable all

/// @param dX
/// @param dY
/// @param buttonHold

function GuiNavGamepad(_dX, _dY, _buttonHold)
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