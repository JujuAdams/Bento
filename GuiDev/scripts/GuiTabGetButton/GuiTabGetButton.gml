// Feather disable all

/// Returns the instance ID of the currently open tab button. This function will return `noone`
/// if no tab is open.
/// 
/// @param tabIdent
/// @param [layer=current]

function GuiTabGetButton(_tabIdent, _layer = undefined)
{
    var _tabData = __GuiTabGetData(_tabIdent, _layer);
    if (_tabData == undefined) return noone;
    
    return _tabData.__button;
}