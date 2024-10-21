// Feather disable all

/// Moves the children of an instance but does not move the instance itself.
/// 
/// @param dX
/// @param dY
/// @param [instance=id]

function GuiMoveChildren(_dX, _dY, _instance = id)
{
    if ((_dX == 0) && (_dY == 0)) return;
    
    with(_instance)
    {
        var _array = __childInsideArray;
        var _i = 0;
        repeat(array_length(_array))
        {
            GuiMove(_dX, _dY, _array[_i]);
            ++_i;
        }
        
        var _array = __childOutsideArray;
        var _i = 0;
        repeat(array_length(_array))
        {
            GuiMove(_dX, _dY, _array[_i]);
            ++_i;
        }
    }
}