// Feather disable all

/// Destroys the tab instance currently opened by a host.
/// 
/// @param hostInstance

function GuiTabClose(_hostInstance)
{
    with(_hostInstance)
    {
        if (not __tabsEnabled)
        {
            __GuiError("GuiTabSetupHost() not called for host instance");
        }
        
        GuiDestroy(__tabsChild);
    }
}