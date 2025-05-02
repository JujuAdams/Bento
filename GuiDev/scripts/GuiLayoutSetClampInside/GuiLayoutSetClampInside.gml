// Feather disable all

/// @param state
/// @param [instance=self]

function GuiLayoutSetClampInside(_state, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (__layoutClampInside != _state)
        {
            __layoutClampInside = _state;
            __environment.__layoutDirty = true;
        }
    }
}