// Feather disable all

/// @param [element=self]

function BentoResetPosition(_element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__positionOverride)
        {
            __positionX = 0;
            __positionY = 0;
            __positionInnerCoordSpace = true;
            __positionOverride = false;
            
            __BentoOffsetMarkDirty();
        }
    }
}