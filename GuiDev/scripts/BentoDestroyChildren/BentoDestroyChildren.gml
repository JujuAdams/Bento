// Feather disable all

/// Destroys every child of a parent element.
/// 
/// @param [parent=self]

function BentoDestroyChildren(_parent = self)
{
    if (not BentoExists(_parent)) return;
    
    with(_parent.BENTO_VARS)
    {
        var _array = __childArray;
        
        var _i = array_length(_array)-1;
        repeat(array_length(_array))
        {
            BentoDestroy(_array[_i].__attachedElement);
            --_i;
        }
        
        array_resize(_array, 0);
        
        //No children = No problem
        __drawOrderDirty = false;
    }
}