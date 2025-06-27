// Feather disable all

/// Returns whether the navigation mode has been set to `GUI_MODE_KEYBOARD`.
/// 
/// @param [layer=current]

function BentoUsingKeyboard(_layer = undefined)
{
    static _system = __BentoSystem();
    
    _layer ??= _system.__layerCurrent;
    return (_layer.__navMode == GUI_MODE_KEYBOARD);
}