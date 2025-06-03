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
            
            with(__layer)
            {
                __stepDirty      = true; //TODO - Do we need to regenerate Step order here?
                __hoverableDirty = true;
                __drawDirty      = true;
            }
        }
    }
}