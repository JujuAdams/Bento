// Feather disable all

/// Executes a function for each child of a parent. The function will be rescoped and executed in
/// the scope of the child. Execution will happen in the reverse of the order that children appear
/// in the array returned by `BentoGetChildArray()`. You may use this function to delete children
/// if you like.
/// 
/// The callback is executed with two parameters. The first parameter is the index of the child.
/// This is 0-indexed with the first child being index `0`. The second parameter is the metadata
/// defined when calling `BentoForeachChild()`. The metadata can be any datatype.
/// 
/// @param function
/// @param [metadata]
/// @param [parent=self]

function BentoForeachChildReverse(_function, _metadata = undefined, _parent = self)
{
    if (not BentoExists(_parent)) return;
    
    var _childArray = _parent.BENTO_VARS.__childArray;
    var _i = array_length(_childArray)-1;
    repeat(_i+1)
    {
        var _method = method(_childArray[_i].__attachedElement, _function);
        _method(_i, _metadata);
        --_i;
    }
}