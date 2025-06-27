// Feather disable all

/// @param [layer=current]

function BentoCursorGetPressY(_layer = undefined)
{
    static _system = __BentoSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        return __navPointer? __mousePressY : __directionalLastY;
    }
}