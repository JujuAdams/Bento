// Feather disable all

/// @param testFunction
/// @param [element=self]

function BentoCarrySetTargetFunction(_testFunction, _element = self)
{
    with(__BentoGetVars(_element))
    {
        __carryTargetFunc = _testFunction;
    }
}