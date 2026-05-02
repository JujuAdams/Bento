// Feather disable all

/// Sets up a condition that hovers the `target` element when the `trigger` element is destroyed.
/// You may call this function multiple times to override the target. You may set the target to
/// `undefined` to hover no target.
/// 
/// N.B. You can set up this condition in any input mode but the `target` element will only be
///      hovered when the input mode is set to `BENTO_MODE_KEYBOARD` or `BENTO_MODE_GAMEPAD`.
/// 
/// N.B. If multiple elements with triggers are destroyed at the same time, which element ends up
///      getting hovered in not guaranteed. Try to only set up one trigger at a time to avoid
///      unexpected results.
/// 
/// @param trigger
/// @param target

function BentoHoverOnDestroy(_trigger, _target)
{
    if (not BentoExists(_trigger)) return;
    
    _trigger.BENTO_VARS.__hoverOnDestroy = _target;
}