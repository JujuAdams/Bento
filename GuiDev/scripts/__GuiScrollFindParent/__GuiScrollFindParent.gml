// Feather disable all

/// Finds the nearest scrollable ancestor up the hierarchy.
/// 
/// @param instance

function __GuiScrollFindParent(_element)
{
    if (not GuiExists(_element)) return noone;
    
    var _guiVars = _element.GUI_VARS;
    if (_guiVars.__scrollHori || _guiVars.__scrollVert) return _element;
    
    return __GuiScrollFindParent(_guiVars.__parent);
}