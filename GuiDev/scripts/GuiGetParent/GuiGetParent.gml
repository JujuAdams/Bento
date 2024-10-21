// Feather disable all

/// Returns a hierarchy ancestor of an instance. The default depth (`1`) will return an instance's
/// immediate parent. Setting the depth parameter higher will return an ancestor further up the
/// tree. If a `depth` parameter is higher than the number of ancestors, `GUI_ROOT` will be
/// returned.
/// 
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