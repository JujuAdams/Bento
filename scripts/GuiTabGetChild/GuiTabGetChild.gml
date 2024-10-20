// Feather disable all

/// @param [hostInstance]

function GuiTabGetChild(_hostInstance = GuiTabGetHost())
{
    with(_hostInstance)
    {
        if (not __tabsEnabled) return noone;
        
        return __tabsChild;
    }
    
    return noone;
}