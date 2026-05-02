// Feather disable all

/// Returns if an element is being dragged as a drag & drop item.
/// 
/// @param [element=self]

function BentoCarryIsItem(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return (BentoCarryGetItemForLayer(__layer, undefined) == _element);
    }
    
    return false;
}