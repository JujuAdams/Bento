// Feather disable all

/// Sets up an instance as a tab host for a tab group. This is optional but recommended.
/// 
/// @param tabIdent
/// @param [blockDirectionalWhenOpen=false]
/// @param [instance=self]

function GuiTabSetupHost(_tabIdent, _blockDirectionalWhenOpen = false, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    if (_tabIdent == undefined)
    {
        __GuiError("Tab ident cannot be `undefined`");
    }
    
    var _tabData = __GuiTabEnsure(_tabIdent, _instance.GUI_VARS.__layer);
    _tabData.__host = _instance;
    _tabData.__blockDirectionalWhenOpen = _blockDirectionalWhenOpen;
    
    _instance.GUI_VARS.__tabIdent = _tabIdent;
}