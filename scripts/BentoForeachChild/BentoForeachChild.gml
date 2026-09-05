// Feather disable all

/// Executes a function for each child of a parent. The function will be rescoped and executed in
/// the scope of the child. If you pass an array for the `parametersArray` parameter then the
/// function will be executed with those parameters. Execution will happen in the order that
/// children appear in the array returned by `BentoGetChildArray()`.
/// 
/// N.B. Do not use this function to delete/destroy children. Instead, you must use
///      `BentoForeachChildReverse()` otherwise you will encounter crahses.
/// 
/// @param [parametersArray=[]]
/// @param function
/// @param [parent=self]

function BentoForeachChild(_parametersArray = undefined, _function, _parent = self)
{
    static _emptyArray = [];
    
    if (not BentoExists(_parent)) return;
    
    if (not is_array(_parametersArray))
    {
        _parametersArray = (_parametersArray == undefined)? _emptyArray : [_parametersArray];
    }
    
    var _childArray = _parent.BENTO_VARS.__childArray;
    var _i = 0;
    repeat(array_length(_childArray))
    {
        method_call(method(_childArray[_i].__attachedElement, _function), _parametersArray);
        ++_i;
    }
}