// Feather disable all

/// Sets up an instance as a tab button in a tab group.
/// 
/// @param tabIdent
/// @param [instance=self]

function GuiTabSetupButton(_tabIdent, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    if (_tabIdent == undefined)
    {
        __GuiError("Tab ident cannot be `undefined`");
    }
    
    with(_instance.GUI_VARS)
    {
        __GuiTabEnsure(_tabIdent, __layer);
        __tabIdent = _tabIdent;
    }
}