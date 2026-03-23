// Feather disable all

/// Removes a child from a parent. This is an internal function since reckless use of this function
/// will probably cause serious bugs.
/// 
/// @param child

function __BentoRemoveParent(_child)
{
    if (not BentoExists(_child)) return;
    
    var _parent = _child.BENTO_VARS.__parent;
    
    if (BentoExists(_parent))
    {
        var _parentVars = _parent.BENTO_VARS;
        
        var _array = _parentVars.__childArray;
        var _index = array_get_index(_array, _child.BENTO_VARS);
        if (_index >= 0) array_delete(_array, _index, 1);
        
        var _array = _parentVars.__childDrawArray;
        var _index = array_get_index(_array, _child.BENTO_VARS);
        if (_index >= 0) array_delete(_array, _index, 1);
        
        BentoScrollLimitsMarkDirty(_parent);
    }
    
    _child.BENTO_VARS.__parent = BENTO_NO_ELEMENT;
}