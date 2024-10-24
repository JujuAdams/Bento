// Feather disable all

/// Returns the y-coordinate of the center of the instance according to the library's internal
/// position tracking. This value may be different to `instance.y` if you have manually moved the
/// instance by directly modifying its position.
/// 
/// @param [instance=id]

function GuiGetY(_instance = id)
{
    if (not instance_exists(_instance)) return 0;
    
    return _instance.__yInternal;
}