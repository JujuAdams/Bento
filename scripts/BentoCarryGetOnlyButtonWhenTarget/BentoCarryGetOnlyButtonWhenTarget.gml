// Feather disable all

/// @param [element=self]

function BentoCarryGetOnlyButtonWhenTarget(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return __carryOnlyButtonWhenTarget;
    }
    
    return undefined;
}