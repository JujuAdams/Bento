// Feather disable all

/// Returns whether the navigation mode has been set to `GUI_NAV_TOUCH`.
/// 
/// @param [environment=current]

function GuiNavUsingTouch(_environment = undefined)
{
    static _system = __GuiSystem();
    
    _environment ??= _system.__environmentCurrent;
    return (_environment.__navMode == GUI_NAV_TOUCH);
}