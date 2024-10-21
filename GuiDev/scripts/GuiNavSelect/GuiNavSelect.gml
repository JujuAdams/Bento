// Feather disable all

/// Selects an instance (if possible). This function only works when the navigation mode is set to
/// `GUI_NAV_GAMEPAD`.
/// 
/// @param instance

function GuiNavSelect(_instance)
{
    static _system = __GuiSystem();
    
    _system.__overInstance     = _instance;
    _system.__overInstanceSoft = noone;
}