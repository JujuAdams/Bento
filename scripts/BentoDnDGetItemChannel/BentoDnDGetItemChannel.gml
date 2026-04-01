// Feather disable all

/// @param [element=self]

function BentoDnDGetItemChannel(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return __dndItemChannel;
    }
    
    return undefined;
}