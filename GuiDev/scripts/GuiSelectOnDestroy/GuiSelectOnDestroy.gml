// Feather disable all

/// Sets up a condition that selects the `target` instance when the `trigger` instance is
/// destroyed. You can set up this condition in any navigation mode but the `target` instance
/// will only be selected when the navigation mode is set to `GUI_MODE_KEYBOARD` or `GUI_MODE_GAMEPAD`.
/// 
/// @param trigger
/// @param target

function GuiSelectOnDestroy(_trigger, _target)
{
    if (not __GuiExists(_trigger)) return;
    
    _trigger.GUI_VARS.__selectOnDestroy = _target;
}