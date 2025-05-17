// Feather disable all

/// Selects an instance (if possible). This function only works when the navigation mode is set to
/// `GUI_MODE_KEYBOARD` or `GUI_MODE_GAMEPAD`.
/// 
/// @param instance
/// @param [layer=current]

function GuiSelect(_element, _layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        __overElement     = _element;
        __overElementSoft = noone;
    }
}