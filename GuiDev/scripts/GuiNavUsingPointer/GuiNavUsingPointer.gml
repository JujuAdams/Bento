// Feather disable all

/// Returns whether the navigation mode has been set to `GUI_NAV_MOUSE` or `GUI_NAV_TOUCH`.
/// 
/// @param [environment=current]

function GuiNavUsingPointer(_environment = undefined)
{
    static _system = __GuiSystem();
    
    _environment ??= _system.__environmentCurrent;
    return _environment.__navPointer;
}