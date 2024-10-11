// Feather disable all

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