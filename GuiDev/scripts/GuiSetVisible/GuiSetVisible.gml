// Feather disable all

/// @param state
/// @param [element=self]

function GuiSetVisible(_state, _element = self)
{
    if (not GUI_EXISTS(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__visible == _state) return;
        __visible = _state;
    
        __layer.__stepDirty = true;
        __layer.__drawDirty = true;
    }
}