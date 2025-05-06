// Feather disable all

/// Returns whether the navigation mode has been set to `GUI_NAV_KEYBOARD`.
/// 
/// @param [layer=current]

function GuiNavUsingKeyboard(_layer = undefined)
{
    static _system = __GuiSystem();
    
    _layer ??= _system.__layerCurrent;
    return (_layer.__navMode == GUI_NAV_KEYBOARD);
}