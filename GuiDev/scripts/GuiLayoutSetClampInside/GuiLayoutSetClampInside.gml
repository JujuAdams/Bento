// Feather disable all

/// @param state
/// @param [instance=id]

function GuiLayoutSetClampInside(_state, _instance = id)
{
    static _system = __GuiSystem();
    
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
    {
        if (__layoutClampInside != _state)
        {
            __layoutClampInside = _state;
            _system.__layoutDirty = true;
        }
    }
}