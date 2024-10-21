// Feather disable all

/// Removes a child from a parent. This is an internal function since reckless use of this function
/// will probably cause serious bugs.
/// 
/// @param child

function __GuiRemoveParent(_child)
{
    static _funcRemove = function(_array, _child)
    {
        var _index = array_get_index(_array, _child);
        if (_index >= 0) array_delete(_array, _index, 1);
    }
    
    if (not instance_exists(_child)) return;
    
    var _parent = _child.__parent;
    
    if (instance_exists(_parent))
    {
        _funcRemove(_parent.__childInsideArray,  _child);
        _funcRemove(_parent.__childOutsideArray, _child);
    }
    
    _child.__parent = noone;
}