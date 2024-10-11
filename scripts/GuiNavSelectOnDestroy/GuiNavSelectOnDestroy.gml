// Feather disable all

/// @param trigger
/// @param target

function GuiNavSelectOnDestroy(_trigger, _target)
{
    if (not instance_exists(_trigger)) return;
    
    _trigger.__selectOnDestroy = _target;
}