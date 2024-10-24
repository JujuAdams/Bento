// Feather disable all

/// Sets up an instance as a tab button in a tab group.
/// 
/// @param tabIdent
/// @param [instance=id]

function GuiTabSetupButton(_tabIdent, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    if (_tabIdent == undefined)
    {
        __GuiError("Tab ident cannot be `undefined`");
    }
    
    __GuiTabEnsure(_tabIdent);
    
    _instance.__tabIdent = _tabIdent;
}