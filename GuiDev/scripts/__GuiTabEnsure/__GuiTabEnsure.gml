// Feather disable all

/// @param tabIdent

function __GuiTabEnsure(_tabIdent)
{
    var _tabDict = GUI_ENVIRONMENT.__tabDict;
    var _tabData = _tabDict[$ _tabIdent];
    if (_tabData == undefined)
    {
        _tabData = {
            __host:   noone,
            __button: noone,
            __child:  noone,
            
            __blockDirectionalWhenOpen: false,
        };
        
        _tabDict[$ _tabIdent] = _tabData;
    }
    
    return _tabData;
}