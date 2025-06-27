// Feather disable all

/// @param horizontal
/// @param vertical
/// @param [element=self]

function BentoScrollSetEnabled(_horizontal, _vertical, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if ((__scrollHori != _horizontal) || (__scrollVert != _vertical))
        {
            __scrollHori = _horizontal;
            __scrollVert = _vertical;
            
            BentoScrollLimitsMarkDirty(_element);
        }
    }
}