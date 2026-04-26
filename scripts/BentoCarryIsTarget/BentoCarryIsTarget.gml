// Feather disable all

/// Returns if an element is the hovered target for a drag & drop item. If no element is being
/// dragged as an item then this function returns `false`.
/// 
/// @param [element=self]

function BentoCarryIsTarget(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return (BentoCarryGetTargetForLayer(__layer, undefined) == _element);
    }
    
    return false;
}