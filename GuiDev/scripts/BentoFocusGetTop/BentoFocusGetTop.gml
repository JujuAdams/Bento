// Feather disable all

/// @param [layer=current]

function BentoFocusGetTop(_layer = undefined)
{
    static _system = __BentoSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        return __focusTop;
    }
}