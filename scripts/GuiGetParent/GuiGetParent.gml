// Feather disable all

/// @param [depth=1]
/// @param [instance=id]

function GuiGetParent(_depth = 1, _instance = id)
{
    if (_depth <= 0) return _instance;
    return __GuiGetParentInner(_depth, _instance);
}

/// @param [depth=1]
/// @param [instance=id]

function __GuiGetParentInner(_depth = 1, _instance = id)
{
    if (not instance_exists(_instance)) return noone;
    
    var _parent = _instance.__parent;
    if (_depth <= 1) return _parent;
    
    return __GuiGetParentInner(_depth-1, _parent);
}