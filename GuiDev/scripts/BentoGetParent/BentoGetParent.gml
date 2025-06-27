// Feather disable all

/// Returns a hierarchy ancestor of an instance. The default depth (`1`) will return an instance's
/// immediate parent. Setting the depth parameter higher will return an ancestor further up the
/// tree. If a `depth` parameter is higher than the number of ancestors, `BentoGetRoot()` will be
/// returned.
/// 
/// @param [depth=1]
/// @param [element=self]

function BentoGetParent(_depth = 1, _element = self)
{
    if (_depth <= 0) return _element;
    return __BentoGetParentInner(_depth, _element);
}

/// @param [depth=1]
/// @param [element=self]

function __BentoGetParentInner(_depth = 1, _element = self)
{
    if (not BentoExists(_element)) return GUI_NO_ELEMENT;
    
    var _parent = _element.GUI_VARS.__parent;
    if (_depth <= 1) return _parent;
    
    return __BentoGetParentInner(_depth-1, _parent);
}