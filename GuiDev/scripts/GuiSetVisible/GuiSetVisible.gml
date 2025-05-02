// Feather disable all

/// @param state
/// @param [instance=id]

function GuiSetVisible(_state, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (__visible == _state) return;
        __visible = _state;
    
        __environment.__stepDirty = true;
        __environment.__drawDirty = true;
    }
}