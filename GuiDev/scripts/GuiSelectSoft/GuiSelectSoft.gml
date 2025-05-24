// Feather disable all

/// Preferentially selects an element if no other element is selected. A soft select will only
/// last for a frame and can be overwritten by `GuiSelect()`. This function further only works
/// when the navigation mode is set to `GUI_MODE_KEYBOARD` or `GUI_MODE_GAMEPAD`.
/// 
/// @param element
/// @param [layer=current]

function GuiSelectSoft(_element, _layer = undefined)
{
    static _system = __GuiSystem();
    
    _layer ??= _system.__layerCurrent;
    _layer.__overElementSoft = _element;
}