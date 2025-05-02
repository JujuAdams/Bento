// Feather disable all

/// Selects an instance (if possible). This function only works when the navigation mode is set to
/// `GUI_NAV_DIRECTIONAL`.
/// 
/// @param instance
/// @param [environment=current]

function GuiNavSelect(_instance, _environment = undefined)
{
    static _system = __GuiSystem();
    
    with(_environment ?? _system.__environmentCurrent)
    {
        __overInstance     = _instance;
        __overInstanceSoft = noone;
    }
}