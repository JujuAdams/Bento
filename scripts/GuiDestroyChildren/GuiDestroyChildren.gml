// Feather disable all

/// Destroys every child of a parent GUI instance.
/// 
/// @param [parent=id]

function GuiDestroyChildren(_parent = id)
{
    static __funcDestroy = function(_array)
    {
        var _i = array_length(_array)-1;
        repeat(array_length(_array))
        {
            GuiDestroy(_array[_i]);
            --_i;
        }
        
        array_resize(_array, 0);
    }
    
    with(_parent)
    {
        __funcDestroy(__childInsideArray);
        __funcDestroy(__childOutsideArray);
        
        //No children = No problem
        __orderDirty = false;
    }
}