// Feather disable all

/// @param [element=self]

function BentoDnDIsTarget(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return (BentoDnDGetTarget(__layer, undefined) == _element);
    }
    
    return false;
}