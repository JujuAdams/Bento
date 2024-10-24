// Feather disable all

/// Returns the x-coordinate of the center of the instance according to the library's internal
/// position tracking. This value may be different to `instance.x` if you have manually moved the
/// instance by directly modifying its position.
/// 
/// @param [instance=id]

function GuiGetX(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.__xInternal;
}