// Feather disable all

/// @param state
/// @param [instance=id]

function GuiScissorSetEnabled(_state, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
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