// Feather disable all

/// @param [element=self]

function BentoScrollGetHeight(_element = self)
{
    if (not BentoExists(_element)) return 0;
    
    with(_element.BENTO_VARS)
    {
        if (not __scrollVert) return 0;
        return max(0, __scrollMaxY - __scrollMinY);
    }
    
    return 0;
}