// Feather disable all

/// @param [istance=id]

function GuiTabButtonIsOpen(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    
    var _host = _instance.__tabsHost;
    if (not instance_exists(_host)) return false;
    
    return (_host.__tabsButton == id);
}