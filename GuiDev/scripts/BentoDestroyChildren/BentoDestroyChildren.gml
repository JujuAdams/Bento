// Feather disable all

/// Destroys every child of a parent UI element.
/// 
/// @param [parent=self]

function BentoDestroyChildren(_parent = self)
{
    if (not BentoExists(_parent)) return;
    
    with(_parent.GUI_VARS)
    {
        var _array = __childArray;
        
        var _i = array_length(_array)-1;
        repeat(array_length(_array))
        {
            BentoDestroy(_array[_i]);
            --_i;
        }
        
        array_resize(_array, 0);
        
        //No children = No problem
        __drawOrderDirty = false;
    }
}