// Feather disable all

/// @param layout
/// @param dX
/// @param dY

function GuiLayoutMove(_layout, _dX, _dY)
{
    var _array = _layout.__instanceArray;
    
    var _i = 0;
    repeat(array_length(_array))
    {
        GuiMove(_array[_i], _dX, _dY);
        ++_i;
    }
}