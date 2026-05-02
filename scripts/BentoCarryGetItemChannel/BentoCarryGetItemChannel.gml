// Feather disable all

/// @param [element=self]

function BentoCarryGetItemChannel(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return __carryItemChannel;
    }
    
    return undefined;
}