// Feather disable all

/// Returns if an element is being dragged as a drag & drop item.
/// 
/// @param [element=self]

function BentoDnDIsItem(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return (BentoDnDGetItem(__layer, undefined) == _element);
    }
    
    return false;
}