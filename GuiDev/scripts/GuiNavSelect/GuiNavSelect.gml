// Feather disable all

/// Selects an instance (if possible). This function only works when the navigation mode is set to
/// `GUI_NAV_DIRECTIONAL`.
/// 
/// @param instance
/// @param [layer=current]

function GuiNavSelect(_element, _layer = undefined)
{
    static _system = __GuiSystem();
    
    with(_layer ?? _system.__layerCurrent)
    {
        __overElement     = _element;
        __overElementSoft = noone;
    }
}