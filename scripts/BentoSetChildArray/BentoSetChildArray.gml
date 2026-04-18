// Feather disable all

/// Sets the children of the target parent element by reading the contents of an array of elements.
/// If the parent exists on a separate layer or in an separate environment then the element will
/// move to that layer and/or environment. Any current children of the parent element that are not
/// found in the input array are called "orphans". If the optional `destroyOrphans` parameter is
/// set to `false` then orphaned elements will have their parent set to the root of their layer. If
/// `destroyOrphans` is set to `true` (the default) then the orphaned elements will be destroyed
/// entirely.
/// 
/// @param array
/// @param [parent=self]
/// @param [destroyOrphans=true]

function BentoSetChildArray(_inputArray, _parent = self, _destroyOrphans = true)
{
    if (not BentoExists(_parent)) return;
    
    var _root = BentoLayerGetRoot(_parent.BENTO_VARS.__layer);
    var _bentoVarsArray = _parent.BENTO_VARS.__childArray;
    
    //Handle any elements that are children of the parent but are not in the input child array
    var _i = array_length(_bentoVarsArray)-1;
    repeat(array_length(_bentoVarsArray))
    {
        var _element = _bentoVarsArray[_i].__attachedElement;
        if (array_get_index(_inputArray, _element) < 0)
        {
            if (_destroyOrphans)
            {
                BentoDestroy(_element);
            }
            else
            {
                BentoSetParent(_root, _element);
            }
        }
        
        --_i;
    }
    
    //Remove all input element from their parent. This, in combination with the above, should
    //ensure the parent element has no children
    var _i = 0;
    repeat(array_length(_inputArray))
    {
        __BentoRemoveParent(_inputArray[_i]);
        ++_i;
    }
    
    //Add all the input elements to the parent. Because the parent has no children at this point,
    //this means the order of the input child elements should be retained
    var _i = 0;
    repeat(array_length(_inputArray))
    {
        BentoSetParent(_parent, _inputArray[_i]);
        ++_i;
    }
}