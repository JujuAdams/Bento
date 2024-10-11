// Feather disable all

/// Sets whether a GUI instance is disabled. A disabled instance will not be interactible nor will
/// it be visible. The children of a disabled instance will not be interactible or visible either.
/// 
/// @param instance
/// @param state

function GuiSetDisable(_instance, _state)
{
    static _system          = __GuiSystem();
    static _dirtyOrderArray = __GuiSystem().__dirtyOrderArray;
    
    if (not instance_exists(_instance)) return;
    if (_instance.__disable == _state) return;
    
    _system.__stepDirty = true;
    _system.__drawDirty = true;
    
    _instance.__disable = _state;
}