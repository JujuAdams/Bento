// Feather disable all

/// Opens a tab. The existing tab child, if one exists, will be destroyed.
/// 
/// @param child
/// @param [hostInstance]
/// @param [button=id]

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
        
        GuiDestroy(__tabsChild);
        
        __tabsButton = _button;
        __tabsChild  = _child;
        
        _child.__tabsHost = id;
    }
}