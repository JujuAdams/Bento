// Feather disable all

/// Fills and then returns an array of elements that are the children of the targeted parent
/// element. This function is more expensive than might be expected. You may provide an existing
/// array that should be used to contain child element references via the optional `outputArray`
/// parameter. If no output array is given then a new array will be created.
/// 
/// @param [parent=self]
/// @param [outputArray]

function BentoGetChildArray(_parent = self, _outputArray = [])
{
    if (BentoExists(_parent))
    {
        var _bentoVarsArray = _parent.BENTO_VARS.__childArray;
        var _childCount = array_length(_bentoVarsArray);
        
        array_resize(_outputArray, _childCount);
        
        var _i = 0;
        repeat(_childCount)
        {
            _outputArray[@ _i] = _bentoVarsArray[_i].__attachedElement;
            ++_i;
        }
    }
    
    return _outputArray;
}