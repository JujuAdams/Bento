// Feather disable all

/// Applies a scroll offset to an instance. This function will also move the `xstart` and `ystart`
/// position so that animations (hopefully) still look correct.
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
                
                xstart += _dX;
                ystart += _dY;
            }
            
            ++_i;
        }
    }
}