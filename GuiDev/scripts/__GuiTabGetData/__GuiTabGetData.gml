// Feather disable all

/// @param tabIdent
/// @param [layer=current]

function __GuiTabGetData(_tabIdent, _layer = undefined)
{
    static _system = __GuiSystem();
    
    _layer ??= _system.__layerCurrent;
    return _layer.__tabDict[$ _tabIdent];
}