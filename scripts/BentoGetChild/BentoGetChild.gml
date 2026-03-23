// Feather disable all

/// Returns the nth child of a parent, where an index of `0` will return the first child element.
/// If a child cannot be found (the index is too high or too low) then this function will return
/// `undefined`.
/// 
/// @param index
/// @param [parent=self]

function BentoGetChild(_index, _parent = self)
{
    if ((_index < 0) || (not BentoExists(_parent))) return undefined;
    
    var _array = _parent.BENTO_VARS.__childArray;
    if (_index >= array_length(_array)) return undefined;
    
    return _array[_index].__attachedElement;
}