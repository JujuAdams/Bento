// Feather disable all

/// @param [element=self]

function BentoScrollGetWidth(_element = self)
{
    if (not BentoExists(_element)) return 0;
    
    with(_element.GUI_VARS)
    {
        if (not __scrollHori) return 0;
        return max(0, __scrollMaxX - __scrollMinX);
    }
    
    return 0;
}