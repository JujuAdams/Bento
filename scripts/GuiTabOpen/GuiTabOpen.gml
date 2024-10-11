// Feather disable all

/// @param child
/// @param [hostInstance]
/// @param [button]

function GuiTabOpen(_child, _hostInstance = undefined, _button = id)
{
    if (_hostInstance == undefined)
    {
        _hostInstance = GuiTabGetHost(_button);
    }
    
    with(_hostInstance)
    {
        if (not __tabsEnabled)
        {
            __GuiError("GuiTabSetupHost() not called for host instance");
        }
        
        __tabsButton = _button;
        __tabsChild  = _child;
        
        _child.__tabsHost = id;
    }
}