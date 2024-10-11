// Feather disable all

/// @param hostInstance

function GuiTabGetButton(_hostInstance)
{
    with(_hostInstance)
    {
        if (not __tabsEnabled) return noone;
        
        return __tabsButton;
    }
    
    return noone;
}