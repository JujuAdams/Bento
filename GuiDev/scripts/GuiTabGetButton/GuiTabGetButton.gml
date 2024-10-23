// Feather disable all

/// Returns the instance ID of the currently open tab button. This function will return `noone`
/// if no tab is open.
/// 
/// @param tabIdent

function GuiTabGetButton(_tabIdent)
{
    var _tabData = __GuiTabGetData(_tabIdent);
    if (_tabData == undefined) return noone;
    
    return _tabData.__button;
}