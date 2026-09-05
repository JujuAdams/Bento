// Feather disable all

/// Executes a function for each child of a parent. The function will be rescoped and executed in
/// the scope of the child. If you pass an array for the `parametersArray` parameter then the
/// function will be executed with those parameters. Execution will happen in the reverse of the
/// order that children appear in the array returned by `BentoGetChildArray()`.
/// 
/// @param [parametersArray=[]]
/// @param function
/// @param [parent=self]

function BentoForeachChildReverse(_parametersArray = undefined, _function, _parent = self)
{
    static _emptyArray = [];
    
    if (not BentoExists(_parent)) return;
    
    _parametersArray ??= _emptyArray;
    
    var _childArray = _parent.BENTO_VARS.__childArray;
    var _i = array_length(_childArray)-1;
    repeat(_i+1)
    {
        method_call(method(_childArray[_i].__attachedElement, _function), _parametersArray);
        --_i;
    }
}