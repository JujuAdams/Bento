// Feather disable all

/// Preferentially selects an instance if no other instance is selected. A soft select will only
/// last for a frame and can be overwritten by `GuiNavSelect()`. This function further only works
/// when the navigation mode is set to `GUI_NAV_KEYBOARD` or `GUI_NAV_GAMEPAD`.
/// 
/// @param instance
/// @param [layer=current]

function GuiNavSelectSoft(_element, _layer = undefined)
{
    static _system = __GuiSystem();
    
    _layer ??= _system.__layerCurrent;
    _layer.__overElementSoft = _element;
}