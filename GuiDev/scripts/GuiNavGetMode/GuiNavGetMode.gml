// Feather disable all

/// Returns the current navigation mode, as set by `GuiNavSetMode()`. This will be one of the
/// following constants:
/// 
/// - `GUI_NAV_UNKNOWN`
/// - `GUI_NAV_MOUSE`
/// - `GUI_NAV_GAMEPAD`
/// - `GUI_NAV_TOUCH`

function GuiNavGetMode()
{
    static _system = __GuiSystem();
    
    return _system.__navMode;
}