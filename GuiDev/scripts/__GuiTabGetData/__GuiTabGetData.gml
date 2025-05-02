// Feather disable all

/// @param tabIdent
/// @param [environment=current]

function __GuiTabGetData(_tabIdent, _environment = undefined)
{
    static _system = __GuiSystem();
    
    _environment ??= _system.__environmentCurrent;
    return _environment.__tabDict[$ _tabIdent];
}