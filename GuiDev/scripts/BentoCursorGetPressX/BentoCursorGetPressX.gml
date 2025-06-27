// Feather disable all

/// @param [layer=current]

function BentoCursorGetPressX(_layer = undefined)
{
    static _system = __BentoSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        return __navPointer? __mousePressX : __directionalLastX;
    }
}