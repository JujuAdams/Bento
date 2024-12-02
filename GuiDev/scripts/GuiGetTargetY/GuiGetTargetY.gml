// Feather disable all

/// Returns the y-coordinate of the instance according to the library's internal position tracking.
/// This value may be different to `instance.y` if you have manually moved the instance by directly
/// modifying its position.
/// 
/// @param [instance=id]

function GuiGetTargetY(_instance = id)
{
    return _instance.__yTarget;
}