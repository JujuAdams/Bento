// Feather disable all

/// @param instance
/// @param host

function GuiTabSetupButton(_instance, _host)
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