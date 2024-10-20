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
        GuiMove(_dX, _dY, _array[_i]);
        ++_i;
    }
}