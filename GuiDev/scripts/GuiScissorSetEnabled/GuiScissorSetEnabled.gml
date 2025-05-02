// Feather disable all

/// @param state
/// @param [instance=self]

function GuiScissorSetEnabled(_state, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (__scissorEnabled != _state)
        {
            __scissorEnabled = _state;
            
            __environment.__stepDirty = true;
            __environment.__drawDirty = true;
            
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