// Feather disable all

/// Returns the scroll *parameter* for the x-axis. This is a value from `0` to `1` (inclusive)
/// where a value of `0` indicates no scrolling and `1` indicates scrolling to the right of the
/// content children inside the element.
/// 
/// @param [element=self]

function BentoScrollGetParamX(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return 1 - clamp((__scrollX - __scrollMinX) / max(0.0001, __scrollMaxX - __scrollMinX), 0, 1);
    }
    
    return 0;
}