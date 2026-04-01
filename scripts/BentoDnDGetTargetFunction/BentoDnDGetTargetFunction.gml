// Feather disable all

/// @param [element=self]

function BentoDnDGetTargetFunction(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return __dndTargetFunc;
    }
    
    return undefined;
}