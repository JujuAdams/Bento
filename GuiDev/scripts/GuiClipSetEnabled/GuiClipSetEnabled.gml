// Feather disable all

/// @param state
/// @param [element=self]

function GuiClipSetEnabled(_state, _element = self)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__scissorEnabled != _state)
        {
            __scissorEnabled = _state;
            
            __layer.__stepDirty = true;
            __layer.__drawDirty = true;
        }
    }
}