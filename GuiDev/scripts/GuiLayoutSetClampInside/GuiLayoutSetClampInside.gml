// Feather disable all

/// @param state
/// @param [element=self]

function GuiLayoutSetClampInside(_state, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__layoutClampInside != _state)
        {
            __layoutClampInside = _state;
            __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
        }
    }
}