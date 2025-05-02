// Feather disable all

/// @param state
/// @param [instance=id]

function GuiLayoutSetClampInside(_state, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
    {
        if (__layoutClampInside != _state)
        {
            __layoutClampInside = _state;
            __environment.__layoutDirty = true;
        }
    }
}