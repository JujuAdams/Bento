// Feather disable all

/// Returns whether the navigation mode has been set to `GUI_NAV_DIRECTIONAL`.
/// 
/// @param [environment=current]

function GuiNavUsingDirectional(_environment = undefined)
{
    static _system = __GuiSystem();
    
    _environment ??= _system.__environmentCurrent;
    return (_environment.__navMode == GUI_NAV_DIRECTIONAL);
}