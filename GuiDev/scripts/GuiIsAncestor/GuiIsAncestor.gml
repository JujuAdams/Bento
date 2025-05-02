// Feather disable all

/// Returns if the given child instance is a descendent of the given ancestor instance.
/// 
/// @param ancestor
/// @param child

function GuiIsAncestor(_ancestor, _child)
{
    if (not GUI_EXISTS(_ancestor)) return false;
    
    return __GuiIsAncestorInner(_ancestor, _child);
}

function __GuiIsAncestorInner(_ancestor, _child)
{
    if (not GUI_EXISTS(_child)) return false;
    if (_ancestor == _child) return true;
    
    return __GuiIsAncestorInner(_ancestor, _child.GUI_VARS.__parent);
}