// Feather disable all

/// Sets up a condition that selects the `target` instance when the `trigger` instance is
/// destroyed. You can set up this condition in any navigation mode but the `target` instance
/// will only be selected when the navigation mode is set to `GUI_NAV_DIRECTIONAL`.
/// 
/// @param trigger
/// @param target

function GuiNavSelectOnDestroy(_trigger, _target)
{
    if (not instance_exists(_trigger)) return;
    
    _trigger.__selectOnDestroy = _target;
}