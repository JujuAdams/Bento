// Feather disable all

/// @param [element=self]

function BentoDnDGetTargetChannel(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return __dndTargetFunc;
    }
    
    return undefined;
}