// Feather disable all

/// Finds the nearest scrollable ancestor up the hierarchy.
/// 
/// @param instance

function __BentoScrollFindParent(_element)
{
    if (not BentoExists(_element)) return GUI_NO_ELEMENT;
    
    var _guiVars = _element.GUI_VARS;
    if (_guiVars.__scrollHori || _guiVars.__scrollVert) return _element;
    
    return __BentoScrollFindParent(_guiVars.__parent);
}