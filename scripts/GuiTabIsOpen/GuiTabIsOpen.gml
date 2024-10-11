// Feather disable all

/// @param hostInstance

function GuiTabIsOpen(_hostInstance)
{
    with(_hostInstance)
    {
        if (not __tabsEnabled) return false;
        
        return instance_exists(__tabsChild);
    }
    
    return false;
}