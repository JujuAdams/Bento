// Feather disable all

/// Returns if the given child instance is a descendent of the given ancestor instance.
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
    
    //Compare the GUI_VARS struct because sometimes GameMaker does weird things with instance references
    if (_ancestor.GUI_VARS == _child.GUI_VARS) return true;
    
    return __BentoIsAncestorInner(_ancestor, _child.GUI_VARS.__parent);
}