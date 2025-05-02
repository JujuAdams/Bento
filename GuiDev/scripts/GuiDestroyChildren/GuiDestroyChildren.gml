// Feather disable all

/// Destroys every child of a parent GUI instance.
/// 
/// @param [parent=id]

function GuiDestroyChildren(_parent = id)
{
    if (not instance_exists(_parent)) return;
    
    with(_parent.GUI_VARS)
    {
        var _array = __childArray;
        
        var _i = array_length(_array)-1;
        repeat(array_length(_array))
        {
            GuiDestroy(_array[_i]);
            --_i;
        }
        
        array_resize(_array, 0);
        
        //No children = No problem
        __childOrderDirty = false;
    }
}