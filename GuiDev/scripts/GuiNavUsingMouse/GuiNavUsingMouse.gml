// Feather disable all

/// Returns whether the navigation mode has been set to `GUI_NAV_MOUSE`.
/// 
/// @param [environment=current]

function GuiNavUsingMouse(_environment = undefined)
{
    static _system = __GuiSystem();
    
    _environment ??= _system.__environmentCurrent;
    return (_environment.__navMode == GUI_NAV_MOUSE);
}