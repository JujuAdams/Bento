// Feather disable all

/// Opens a tab. The existing tab child, if one exists, will be destroyed.
/// 
/// @param child
/// @param [button=id]

function GuiTabOpen(_child, _button = id)
{
    if (not instance_exists(_button))
    {
        __GuiError("Button instance doesn't exist");
    }
    
    if (_button.__tabIdent == undefined)
    {
        __GuiError("GuiTabSetupButton() hasn't been called for the button instance");
    }
    
    with(__GuiTabEnsure(_button.__tabIdent))
    {
        GuiDestroy(__child);
        
        __button = _button;
        __child  = _child;
        
        _child.__tabIdentChildOf = _button.__tabIdent;
    }
}