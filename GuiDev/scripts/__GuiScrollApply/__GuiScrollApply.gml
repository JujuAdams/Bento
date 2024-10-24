// Feather disable all

/// Applies a scroll offset to an instance.
/// 
/// @param instance
/// @param dX
/// @param dY

function __GuiScrollApply(_instance, _dX, _dY)
{
    with(_instance)
    {
        var _i = 0;
        repeat(array_length(__childInsideArray))
        {
            with(__childInsideArray[_i])
            {
                x += _dX;
                y += _dY;
                
                __xInternal += _dX;
                __yInternal += _dY;
            }
            
            ++_i;
        }
    }
}