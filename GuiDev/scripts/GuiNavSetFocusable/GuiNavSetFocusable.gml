// Feather disable all

/// @param state
/// @param [element=self]

function GuiNavSetFocusable(_state, _element = self)
{
    if (not GUI_EXISTS(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__focusable == _state) return;
        
        __layer.__stepDirty = true;
        
        if (not _state) GuiNavSetFocus(false, _element);
        __focusable = _state;
    }
    
}