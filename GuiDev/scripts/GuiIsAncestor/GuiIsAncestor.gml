// Feather disable all

/// Returns if the given child instance is a descendent of the given ancestor instance.
/// 
/// @param ancestor
/// @param child

function GuiIsAncestor(_ancestor, _child)
{
    if (not instance_exists(_ancestor)) return false;
    
    return __GuiIsAncestorInner(_ancestor, _child);
}

function __GuiIsAncestorInner(_ancestor, _child)
{
    if (not instance_exists(_child)) return false;
    if (_ancestor == _child) return true;
    
    return __GuiIsAncestorInner(_ancestor, _child.__parent);
}