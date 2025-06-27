// Feather disable all

/// Sets up a condition that selects the `target` instance when the `trigger` instance is
/// destroyed. You can set up this condition in any navigation mode but the `target` instance
/// will only be selected when the navigation mode is set to `BENTO_MODE_KEYBOARD` or
/// `BENTO_MODE_GAMEPAD`.
/// 
/// @param trigger
/// @param target

function BentoSelectOnDestroy(_trigger, _target)
{
    if (not BentoExists(_trigger)) return;
    
    _trigger.BENTO_VARS.__selectOnDestroy = _target;
}