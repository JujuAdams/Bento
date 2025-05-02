// Feather disable all

/// @param tabIdent
/// @param [environment=current]

function __GuiTabEnsure(_tabIdent, _environment = undefined)
{
    static _system = __GuiSystem();
    
    _environment ??= _system.__environmentCurrent;
    var _tabDict = _environment.__tabDict;
    
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