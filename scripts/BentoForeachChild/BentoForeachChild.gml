// Feather disable all

/// Executes a function for each child of a parent. The function will be rescoped and executed in
/// the scope of the child. Execution will happen in the order that children appear in the array
/// returned by `BentoGetChildArray()`.
/// 
/// The callback is executed with two parameters. The first parameter is the index of the child.
/// This is 0-indexed with the first child being index `0`. The second parameter is the metadata
/// defined when calling `BentoForeachChild()`. The metadata can be any datatype.
/// 
/// N.B. Do not use this function to delete/destroy children. Instead, you must use
///      `BentoForeachChildReverse()` otherwise you will encounter crahses.
/// 
/// @param function
/// @param [metadata]
/// @param [parent=self]

function BentoForeachChild(_function, _metadata = undefined, _parent = self)
{
    if (not BentoExists(_parent)) return;
    
    var _childArray = _parent.BENTO_VARS.__childArray;
    var _i = 0;
    repeat(array_length(_childArray))
    {
        var _method = method(_childArray[_i].__attachedElement, _function);
        _method(_i, _metadata);
        ++_i;
    }
}