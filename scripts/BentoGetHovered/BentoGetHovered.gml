// Feather disable all

/// Returns whether an element is currently hovered.
/// 
/// @param [element=self]

function BentoGetHovered(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return ((__hoverState & __BENTO_STATE_START) > 0);
    }
    
    return false;
}