// Feather disable all

/// Sets up an instance as a tab button.
/// 
/// @param [host=parent]
/// @param [instance=id]

function GuiTabSetupButton(_host = GuiGetParent(), _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    if (not instance_exists(_host))
    {
        __GuiError("Host instance doesn't exist");
    }
    
    if (not _host.__tabsEnabled)
    {
        __GuiError("Host instance hasn't called GuiTabSetupHost()");
    }
    
    _instance.__tabsHost = _host;
}