// Feather disable all

/// Returns the current navigation mode, as set by `GuiSetMode()`. This will be one of the
/// following constants:
/// 
/// - `GUI_MODE_UNKNOWN`
/// - `GUI_MODE_MOUSE`
/// - `GUI_MODE_KEYBOARD`
/// - `GUI_MODE_GAMEPAD`
/// - `GUI_MODE_TOUCH`
/// 
/// @param [layer=current]

function GuiGetMode(_layer = undefined)
{
    static _system = __GuiSystem();
    
    _layer ??= _system.__layerCurrent;
    return _layer.__navMode;
}