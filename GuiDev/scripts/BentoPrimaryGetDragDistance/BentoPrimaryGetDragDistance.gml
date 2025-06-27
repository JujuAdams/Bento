// Feather disable all

/// Returns the distance that the pointer has moved between after pressing the primary action. If
/// the navigation mode isn't `GUI_MODE_MOUSE` or `GUI_MODE_TOUCH` this function returns `0`.
/// 
/// @param [layer=current]

function BentoPrimaryGetDragDistance(_layer = undefined)
{
    static _system = __BentoSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        return __navPointer? point_distance(__mousePressX, __mousePressY, __mouseX, __mouseY) : 0;
    }
}