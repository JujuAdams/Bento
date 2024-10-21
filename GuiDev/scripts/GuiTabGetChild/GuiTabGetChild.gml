// Feather disable all

/// Returns the instance ID of the currently open tab child. This function will return `noone` if
/// no tab is open.
/// 
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