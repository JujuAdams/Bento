// Feather disable all

/// Returns the scroll *parameter* for the y-axis. This is a value from `0` to `1` (inclusive)
/// where a value of `0` indicates no scrolling and `1` indicates scrolling to the right of the
/// content children inside the element.
/// 
/// @param [element=self]

function BentoScrollGetParamY(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return 1 - clamp((__scrollY - __scrollMinY) / max(0.0001, __scrollMaxY - __scrollMinY), 0, 1);
    }
    
    return 0;
}