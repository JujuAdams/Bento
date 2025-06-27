// Feather disable all

/// Finds the nearest scrollable ancestor up the hierarchy.
/// 
/// @param instance

function __BentoScrollFindParent(_element)
{
    if (not BentoExists(_element)) return BENTO_NO_ELEMENT;
    
    var _bentoVars = _element.BENTO_VARS;
    if (_bentoVars.__scrollHori || _bentoVars.__scrollVert) return _element;
    
    return __BentoScrollFindParent(_bentoVars.__parent);
}