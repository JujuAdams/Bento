// Feather disable all

/// Returns if the given child element is a descendent of the given ancestor element.
/// 
/// @param ancestor
/// @param child

function BentoIsAncestor(_ancestor, _child)
{
    if (not BentoExists(_ancestor)) return false;
    
    return __BentoIsAncestorInner(_ancestor, _child);
}

function __BentoIsAncestorInner(_ancestor, _child)
{
    if (not BentoExists(_child)) return false;
    
    //Compare the BENTO_VARS struct because sometimes GameMaker does weird things with instance/struct references
    if (_ancestor.BENTO_VARS == _child.BENTO_VARS) return true;
    
    return __BentoIsAncestorInner(_ancestor, _child.BENTO_VARS.__parent);
}