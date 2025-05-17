// Feather disable all

/// Returns whether the navigation mode has been set to `GUI_MODE_TOUCH`.
/// 
/// @param [layer=current]

function GuiUsingTouch(_layer = undefined)
{
    static _system = __GuiSystem();
    
    _layer ??= _system.__layerCurrent;
    return (_layer.__navMode == GUI_MODE_TOUCH);
}