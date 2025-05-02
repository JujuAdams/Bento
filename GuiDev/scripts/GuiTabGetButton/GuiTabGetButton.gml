// Feather disable all

/// Returns the instance ID of the currently open tab button. This function will return `noone`
/// if no tab is open.
/// 
/// @param tabIdent
/// @param [environment=current]

function GuiTabGetButton(_tabIdent, _environment = undefined)
{
    var _tabData = __GuiTabGetData(_tabIdent, _environment);
    if (_tabData == undefined) return noone;
    
    return _tabData.__button;
}