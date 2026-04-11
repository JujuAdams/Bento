// Feather disable all

/// Finds the nearest scrollable ancestor up the hierarchy.
/// 
/// @param element

//TODO - Can this be optimized by storing the scroll parent during offset calculation?

function __BentoFindScrollElement(_element)
{
    if (not BentoExists(_element)) return BENTO_NO_ELEMENT;
    
    var _bentoVars = _element.BENTO_VARS;
    if (_bentoVars.__scrollHori || _bentoVars.__scrollVert) return _element;
    
    return __BentoFindScrollElement(_bentoVars.__parent);
}