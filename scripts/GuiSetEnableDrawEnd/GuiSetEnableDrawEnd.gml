// Feather disable all

/// @param state
/// @param [instance=id]

function GuiSetEnableDrawEnd(_state, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    if (_instance.__drawEnd == _state) return;
    
    _system.__drawDirty = true;
    
    _instance.__drawEnd = _state;
}