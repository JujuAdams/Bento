// Feather disable all

/// Preferentially selects an instance if no other instance is selected. A soft select will only
/// last for a frame and can be overwritten by `GuiNavSelect()`. This function further only works
/// when the navigation mode is set to `GUI_NAV_GAMEPAD`.
/// 
/// @param instance

function GuiNavSelectSoft(_instance)
{
    static _system = __GuiSystem();
    _system.__overInstanceSoft = _instance;
}