// Feather disable all

/// @param [element=self]

function BentoDnDIsItem(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return (BentoDnDGetItem(__layer, undefined) == _element);
    }
    
    return false;
}