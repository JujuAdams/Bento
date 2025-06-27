// Feather disable all

/// @param [element=self]

function BentoGetIndex(_element = self)
{
    var _parent = BentoGetParent(1, _element);
    if (not BentoExists(_parent)) return undefined;
    
    var _index = array_get_index(_parent.BENTO_VARS.__childArray, _element);
    return (_index < 0)? undefined : _index;
}