// Feather disable all

/// Returns the instance ID of the currently open tab child. This function will return `noone` if
/// no tab is open.
/// 
/// @param tabIdent

function GuiTabGetChild(_tabIdent)
{
    var _tabData = __GuiTabGetData(_tabIdent);
    if (_tabData == undefined) return noone;
    
    return _tabData.__child;
}