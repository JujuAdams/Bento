// Feather disable all

/// @param state
/// @param [instance=self]

function GuiSetVisible(_state, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (__visible == _state) return;
        __visible = _state;
    
        __layer.__stepDirty = true;
        __layer.__drawDirty = true;
    }
}