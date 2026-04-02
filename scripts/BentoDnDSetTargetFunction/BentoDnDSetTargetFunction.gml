// Feather disable all

/// @param testFunction
/// @param [element=self]

function BentoDnDSetTargetFunction(_testFunction, _element = self)
{
    with(__BentoGetVars(_element))
    {
        __dndTargetFunc = _testFunction;
    }
}