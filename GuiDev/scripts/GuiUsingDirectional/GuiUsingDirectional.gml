// Feather disable all

/// Returns whether the navigation mode has been set to `GUI_MODE_KEYBOARD` or `GUI_MODE_GAMEPAD`.
/// 
/// @param [layer=current]

function GuiUsingDirectional(_layer = undefined)
{
    static _system = __GuiSystem();
    
    _layer ??= _system.__layerCurrent;
    return _layer.__navDirectional;
}