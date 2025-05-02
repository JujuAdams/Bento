// Feather disable all

/// Finds the nearest scrollable ancestor up the hierarchy.
/// 
/// @param instance

function __GuiScrollFindParent(_instance)
{
    if (not GUI_EXISTS(_instance)) return noone;
    
    var _guiVars = _instance.GUI_VARS;
    if (_guiVars.__scrollHori || _guiVars.__scrollVert) return _instance;
    
    return __GuiScrollFindParent(_guiVars.__parent);
}