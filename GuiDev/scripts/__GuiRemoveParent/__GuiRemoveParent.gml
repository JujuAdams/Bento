// Feather disable all

/// Removes a child from a parent. This is an internal function since reckless use of this function
/// will probably cause serious bugs.
/// 
/// @param child

function __GuiRemoveParent(_child)
{
    if (not GuiExists(_child)) return;
    
    var _parent = _child.GUI_VARS.__parent;
    
    if (GuiExists(_parent))
    {
        var _parentVars = _parent.GUI_VARS;
        
        var _array = _parentVars.__childArray;
        var _index = array_get_index(_array, _child);
        if (_index >= 0) array_delete(_array, _index, 1);
        
        var _array = _parentVars.__childDrawArray;
        var _index = array_get_index(_array, _child);
        if (_index >= 0) array_delete(_array, _index, 1);
    }
    
    GuiScrollLimitsMarkDirty(_parent);
    
    _child.GUI_VARS.__parent = noone;
}