// Feather disable all

/// Returns the distance that the pointer has moved between after pressing the primary action. If
/// the navigation mode isn't `GUI_NAV_MOUSE` or `GUI_NAV_TOUCH` this function returns `0`.

function GuiNavGetDragDistance()
{
    static _system = __GuiSystem();
    
    with(_system)
    {
        if (not __navPointer) return 0;
        
        return point_distance(__mousePressX, __mousePressY, __mouseX, __mouseY);
    }
}