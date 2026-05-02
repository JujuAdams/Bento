// Feather disable all

/// @param [layer=current]

function GuiCursorGetPressX(_layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        return __navPointer? __mousePressX : __directionalLastX;
    }
}