// Feather disable all

/// Sets up an instance as a tab host for a tab group. This is optional but recommended.
/// 
/// @param tabIdent
/// @param [blockGamepadWhenOpen=false]
/// @param [instance=id]

function GuiTabSetupHost(_tabIdent, _blockGamepadWhenOpen = false, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    if (_tabIdent == undefined)
    {
        __GuiError("Tab ident cannot be `undefined`");
    }
    
    var _tabData = __GuiTabEnsure(_tabIdent);
    _tabData.__host = _instance;
    _tabData.__blockGamepadWhenOpen = _blockGamepadWhenOpen;
    
    _instance.__tabIdent = _tabIdent;
}