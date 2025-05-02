// Feather disable all

/// Preferentially selects an instance if no other instance is selected. A soft select will only
/// last for a frame and can be overwritten by `GuiNavSelect()`. This function further only works
/// when the navigation mode is set to `GUI_NAV_DIRECTIONAL`.
/// 
/// @param instance
/// @param [environment=current]

function GuiNavSelectSoft(_instance, _environment = undefined)
{
    static _system = __GuiSystem();
    
    _environment ??= _system.__environmentCurrent;
    _environment.__overInstanceSoft = _instance;
}