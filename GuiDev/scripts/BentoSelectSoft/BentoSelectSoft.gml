// Feather disable all

/// Preferentially selects an element if no other element is selected. A soft select will only
/// last for a frame and can be overwritten by `BentoSelect()`. This function further only works
/// when the navigation mode is set to `GUI_MODE_KEYBOARD` or `GUI_MODE_GAMEPAD`.
/// 
/// @param element
/// @param [layer=current]

function BentoSelectSoft(_element, _layer = undefined)
{
    static _system = __BentoSystem();
    
    _layer ??= _system.__layerCurrent;
    _layer.__hoverElementSoft = _element;
}