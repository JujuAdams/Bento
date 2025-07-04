// Feather disable all

/// Returns the position of an element in its parent's child order. For example, if the element
/// is first then this function will return `0`.
/// 
/// @param [element=self]

function BentoGetIndex(_element = self)
{
    var _parent = BentoGetParent(1, _element);
    if (not BentoExists(_parent)) return undefined;
    
    var _index = array_get_index(_parent.BENTO_VARS.__childArray, _element);
    return (_index < 0)? undefined : _index;
}