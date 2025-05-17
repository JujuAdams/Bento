// Feather disable all

/// @param state
/// @param [element=self]

function GuiSetListener(_state, _element = self)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__listener == _state) return;
        __listener = _state;
        
        __layer.__stepDirty = true;
        __layer.__drawDirty = true;
    }
}