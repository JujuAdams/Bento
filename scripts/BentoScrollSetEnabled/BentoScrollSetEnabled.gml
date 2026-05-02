// Feather disable all

/// Sets whether scrolling is enable in either axis.
/// 
/// @param horizontal
/// @param vertical
/// @param [element=self]

function BentoScrollSetEnabled(_horizontal, _vertical, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if ((__scrollHori != _horizontal) || (__scrollVert != _vertical))
        {
            __scrollHori = _horizontal;
            __scrollVert = _vertical;
            
            BentoScrollLimitsMarkDirty(_element);
        }
    }
}