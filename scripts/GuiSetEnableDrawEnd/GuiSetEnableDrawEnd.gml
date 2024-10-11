// Feather disable all

/// @param [instance=id]
/// @param state

function GuiSetEnableDrawEnd(_instance = id, _state)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    if (_instance.__drawEnd == _state) return;
    
    _system.__drawDirty = true;
    
    _instance.__drawEnd = _state;
}