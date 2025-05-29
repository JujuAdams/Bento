// Feather disable all

/// @param state
/// @parma [element=self]

function GuiFocusSetEncloseChildren(_state, _element = self)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__focusEncloseChildren != _state)
        {
            __focusEncloseChildren = _state;
            __layer.__stepDirty = true;
        }
    }
}