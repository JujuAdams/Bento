// Feather disable all

/// Returns a hierarchy ancestor of an instance. The default depth (`1`) will return an instance's
/// immediate parent. Setting the depth parameter higher will return an ancestor further up the
/// tree. If a `depth` parameter is higher than the number of ancestors, `GuiGetRoot()` will be
/// returned.
/// 
/// @param [depth=1]
/// @param [element=self]
/// @param [ignoreContainer=false]

function GuiGetParent(_depth = 1, _element = self, _ignoreContainer = false)
{
    if (_depth <= 0) return _element;
    return _ignoreContainer? __GuiGetParentInnerIgnoreContainer(_depth, _element) : __GuiGetParentInner(_depth, _element);
}

/// @param [depth=1]
/// @param [element=self]

function __GuiGetParentInner(_depth = 1, _element = self)
{
    if (not GuiExists(_element)) return noone;
    
    var _parent = __GuiGetContainerHost(_element.GUI_VARS.__parent);
    if (_parent == undefined) return noone;
    
    if (_depth <= 1) return _parent;
    
    return __GuiGetParentInner(_depth-1, _parent);
}

/// @param [depth=1]
/// @param [element=self]

function __GuiGetParentInnerIgnoreContainer(_depth = 1, _element = self)
{
    if (not GuiExists(_element)) return noone;
    
    var _parent = _element.GUI_VARS.__parent;
    if (_depth <= 1) return _parent;
    
    return __GuiGetParentInner(_depth-1, _parent);
}