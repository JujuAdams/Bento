// Feather disable all

/// Returns the distance that the pointer has moved between after pressing the primary action. If
/// the navigation mode isn't `GUI_NAV_MOUSE` or `GUI_NAV_TOUCH` this function returns `0`.
/// 
/// @param [environment=current]

function GuiNavGetDragDistance(_environment = undefined)
{
    static _system = __GuiSystem();
    
    with(_environment ?? _system.__environmentCurrent)
    {
        return __navPointer? point_distance(__mousePressX, __mousePressY, __mouseX, __mouseY) : 0;
    }
}