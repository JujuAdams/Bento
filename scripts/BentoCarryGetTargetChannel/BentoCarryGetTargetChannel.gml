// Feather disable all

/// @param [element=self]

function BentoCarryGetTargetChannel(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return __carryTargetChannel;
    }
    
    return undefined;
}