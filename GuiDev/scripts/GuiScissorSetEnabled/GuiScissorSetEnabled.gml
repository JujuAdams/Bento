// Feather disable all

/// @param state
/// @param [element=self]

function GuiScissorSetEnabled(_state, _element = self)
{
    if (not GUI_EXISTS(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (__scissorEnabled != _state)
        {
            __scissorEnabled = _state;
            
            __layer.__stepDirty = true;
            __layer.__drawDirty = true;
            
            //Ensure we have additional scissor variables set
            if (_state)
            {
                GuiSetIfNotDefined("__scissorPadLeft",   0);
                GuiSetIfNotDefined("__scissorPadTop",    0);
                GuiSetIfNotDefined("__scissorPadRight",  0);
                GuiSetIfNotDefined("__scissorPadBottom", 0);
            }
        }
    }
}