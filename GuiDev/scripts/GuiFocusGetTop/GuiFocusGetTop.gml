// Feather disable all

/// @param [layer=current]

function GuiFocusGetTop(_layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        return __focusTop;
    }
}