// Feather disable all

/// Sets an element's position in its parent's child order. This will move other elements around.
/// 
/// @param index
/// @param [element=self]

function BentoSetChildIndex(_index, _element = self)
{
    var _parent = BentoGetParent(1, _element);
    if (not BentoExists(_parent)) return undefined;
    
    var _array = _parent.BENTO_VARS.__childArray;
    var _foundIndex = array_get_index(_array, _element.BENTO_VARS);
    if (_foundIndex < 0)
    {
        //?!
        
        if (BENTO_RUNNING_FROM_IDE)
        {
            __BentoError("Could not find child within parent. Please report this error");
        }
        
        return;
    }
    
    _index = clamp(_index, 0, array_length(_array)-1);
    if (_foundIndex == _index) return;
    
    array_delete(_array, _foundIndex, 1);
    array_insert(_array, _index, _element.BENTO_VARS);
    
    //Changing the element order invalidates a lot of cached data
    _element.BENTO_VARS.__layer.__dirtyFlags |= __BENTO_DIRTY_ALL;
    
    __BentoMarkDrawOrderDirty(_parent);
}