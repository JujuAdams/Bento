// Feather disable all

/// Removes a child from a parent. This is an internal function since reckless use of this function
/// will probably cause serious bugs.
/// 
/// @param child

function __GuiRemoveParent(_child)
{
    if (not instance_exists(_child)) return;
    
    var _parent = _child.GUI_VARS.__parent;
    
    if (instance_exists(_parent))
    {
        var _array = _parent.GUI_VARS.__childArray;
        var _index = array_get_index(_array, _child);
        if (_index >= 0) array_delete(_array, _index, 1);
    }
    
    GuiScrollLimitsMarkDirty(_parent);
    
    _child.GUI_VARS.__parent = noone;
}