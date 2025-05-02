// Feather disable all

/// Returns a hierarchy ancestor of an instance. The default depth (`1`) will return an instance's
/// immediate parent. Setting the depth parameter higher will return an ancestor further up the
/// tree. If a `depth` parameter is higher than the number of ancestors, `GUI_ROOT` will be
/// returned.
/// 
/// @param [depth=1]
/// @param [instance=self]

function GuiGetParent(_depth = 1, _instance = self)
{
    if (_depth <= 0) return _instance;
    return __GuiGetParentInner(_depth, _instance);
}

/// @param [depth=1]
/// @param [instance=self]

function __GuiGetParentInner(_depth = 1, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return noone;
    
    var _parent = _instance.GUI_VARS.__parent;
    if (_depth <= 1) return _parent;
    
    return __GuiGetParentInner(_depth-1, _parent);
}