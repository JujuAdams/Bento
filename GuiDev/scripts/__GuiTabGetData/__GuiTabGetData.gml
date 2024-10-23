// Feather disable all

/// @param tabIdent

function __GuiTabGetData(_tabIdent)
{
    static _tabDict = __GuiSystem().__tabDict;
    
    return _tabDict[$ _tabIdent];
}