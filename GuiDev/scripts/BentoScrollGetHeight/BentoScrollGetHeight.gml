// Feather disable all

/// Returns the height of the scrollable content.
/// 
/// @param [element=self]

function BentoScrollGetHeight(_element = self)
{
    with(__BentoGetVars(_element))
    {
        if (not __scrollVert) return 0;
        return max(0, __scrollMaxY - __scrollMinY);
    }
    
    return 0;
}