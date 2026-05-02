// Feather disable all

/// Returns the position of an element in its parent's child order. For example, if the element
/// is first then this function will return `0`. If the element cannot be found then this function
/// will return `undefined`.
/// 
/// @param [element=self]

function BentoGetChildIndex(_element = self)
{
    if (not BentoExists(_element)) return undefined;
    
    var _parent = BentoGetParent(1, _element);
    if (not BentoExists(_parent)) return undefined;
    
    var _index = array_get_index(_parent.BENTO_VARS.__childArray, _element.BENTO_VARS);
    return (_index < 0)? undefined : _index;
}