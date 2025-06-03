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
            
            //TODO - Do we need to regenerate Step order here?
            __layer.__dirtyFlags |= __GUI_DIRTY_STEP | __GUI_DIRTY_HOVERABLE | __GUI_DIRTY_DRAW;
        }
    }
}