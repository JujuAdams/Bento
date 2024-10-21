// Feather disable all

/// Returns the instance ID of the currently open tab button. This function will return `noone`
/// if no tab is open.
/// 
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