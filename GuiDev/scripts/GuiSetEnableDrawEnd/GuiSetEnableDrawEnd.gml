// Feather disable all

/// Sets whether an instance should execute its Draw Event user event (`GUI_USER_EVENT_DRAW_END`).
/// The Draw End user event is executed after the Draw user event (`GUI_USER_EVENT_DRAW`) and after
/// drawing child instance that are marked as "inside". However, the Draw End user event is
/// executed *before* outside child instances.
/// 
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