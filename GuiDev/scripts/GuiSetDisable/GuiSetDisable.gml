// Feather disable all

/// Sets whether a GUI instance is disabled. A disabled instance will not be interactible nor will
/// it be visible. The children of a disabled instance will not be interactible or visible either.
/// Disabled instance will still affect layouts, however.
/// 
/// @param state
/// @param [instance=self]

function GuiSetDisable(_state, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (__disable == _state) return;
        __disable = _state;
    
        __environment.__stepDirty = true;
        __environment.__drawDirty = true;
    }
}