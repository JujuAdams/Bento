// Feather disable all

/// Returns the x-coordinate of the instance according to the library's internal position tracking.
/// This value may be different to `instance.x` if you have manually moved the instance by directly
/// modifying its position.
/// 
/// @param [instance=id]

function GuiGetTargetX(_instance = id)
{
    return _instance.__xTarget;
}