// Feather disable all

/// Returns the current navigation mode, as set by `GuiNavSetMode()`. This will be one of the
/// following constants:
/// 
/// - `GUI_NAV_UNKNOWN`
/// - `GUI_NAV_MOUSE`
/// - `GUI_NAV_DIRECTIONAL`
/// - `GUI_NAV_TOUCH`
/// 
/// @param [environment=current]

function GuiNavGetMode(_environment = undefined)
{
    static _system = __GuiSystem();
    
    _environment ??= _system.__environmentCurrent;
    return _environment.__navMode;
}