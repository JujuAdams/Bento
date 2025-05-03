// Feather disable all

/// Sets whether a GUI instance is disabled. A disabled instance will not be interactible nor will
/// it be visible. The children of a disabled instance will not be interactible or visible either.
/// Disabled instance will still affect layouts, however.
/// 
/// @param state
/// @param [element=self]

function GuiSetDisable(_state, _element = self)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__disable == _state) return;
        __disable = _state;
    
        __layer.__stepDirty = true;
        __layer.__drawDirty = true;
    }
}