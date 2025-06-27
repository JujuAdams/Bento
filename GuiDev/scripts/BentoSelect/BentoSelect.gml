// Feather disable all

/// Selects an instance (if possible). This function only works when the navigation mode is set to
/// `GUI_MODE_KEYBOARD` or `GUI_MODE_GAMEPAD`.
/// 
/// @param instance
/// @param [layer=current]

function BentoSelect(_element, _layer = undefined)
{
    static _system = __BentoSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        __hoverElement     = _element;
        __hoverElementSoft = GUI_NO_ELEMENT;
    }
}