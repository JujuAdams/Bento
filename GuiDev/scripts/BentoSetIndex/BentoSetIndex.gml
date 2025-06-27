// Feather disable all

/// @param index
/// @param [element=self]

function BentoSetIndex(_index, _element = self)
{
    var _parent = BentoGetParent(1, _element);
    if (not BentoExists(_parent)) return undefined;
    
    var _array = _parent.GUI_VARS.__childArray;
    var _foundIndex = array_get_index(_array, _element);
    if (_foundIndex < 0)
    {
        //?!
        
        if (GUI_RUNNING_FROM_IDE)
        {
            __BentoError("Could not find child within parent. Please report this error");
        }
        
        return;
    }
    
    _index = clamp(_index, 0, array_length(_array)-1);
    if (_foundIndex == _index) return;
    
    array_delete(_array, _foundIndex, 1);
    array_insert(_array, _index, _element);
    
    //Changing the element order invalidates a lot of cached data
    _element.GUI_VARS.__layer.__dirtyFlags |= __GUI_DIRTY_ALL;
    
    __BentoMarkDrawOrderDirty(_parent);
}