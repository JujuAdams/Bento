// Feather disable all

/// @param hostInstance

function GuiTabGetChild(_hostInstance)
{
    with(_hostInstance)
    {
        if (not __tabsEnabled) return noone;
        
        return __tabsChild;
    }
    
    return noone;
}