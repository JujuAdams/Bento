// Feather disable all

/// @param state
/// @param [element=self]

function GuiLayoutSetClampInside(_state, _element = self)
{
    if (not GUI_EXISTS(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__layoutClampInside != _state)
        {
            __layoutClampInside = _state;
            __layer.__layoutDirty = true;
        }
    }
}