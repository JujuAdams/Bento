// Feather disable all

/// @param tabIdent
/// @param [layer=current]

function __GuiTabEnsure(_tabIdent, _layer = undefined)
{
    static _system = __GuiSystem();
    
    _layer ??= _system.__layerCurrent;
    var _tabDict = _layer.__tabDict;
    
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