// Feather disable all

/// @param instance
/// @param [dX=0]
/// @param [dY=0]

function GuiMove(_instance, _dX = 0, _dY = 0)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance)
    {
        x += _dX;
        y += _dY;
        
        if (__scissorState)
        {
            __scissorLeft   += _dX;
            __scissorTop    += _dY;
            __scissorRight  += _dX;
            __scissorBottom += _dY;
        }
        
        var _array = __childInsideArray;
        var _i = 0;
        repeat(array_length(_array))
        {
            GuiMove(_array[_i], _dX, _dY);
            ++_i;
        }
        
        var _array = __childOutsideArray;
        var _i = 0;
        repeat(array_length(_array))
        {
            GuiMove(_array[_i], _dX, _dY);
            ++_i;
        }
    }
}