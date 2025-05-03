// Feather disable all

/// Returns whether the navigation mode has been set to `GUI_NAV_MOUSE` or `GUI_NAV_TOUCH`.
/// 
/// @param [layer=current]

function GuiNavUsingPointer(_layer = undefined)
{
    static _system = __GuiSystem();
    
    _layer ??= _system.__layerCurrent;
    return _layer.__navPointer;
}