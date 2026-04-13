// Feather disable all

/// @param [element=self]

function BentoDnDGetOnlyButtonWhenTarget(_element = self)
{
    with(__BentoGetVars(_element))
    {
        return __dndOnlyButtonWhenTarget;
    }
    
    return undefined;
}