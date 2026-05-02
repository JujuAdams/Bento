// Feather disable all

/// @param [element=self]

function BentoCarryGetTargetFunction(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return __carryTargetFunc;
    }
    
    return undefined;
}