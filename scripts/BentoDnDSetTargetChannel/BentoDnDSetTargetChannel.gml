// Feather disable all

/// @param channel
/// @param [element=self]

function BentoDnDSetTargetChannel(_channel, _element = self)
{
    with(__BentoGetVars(_element))
    {
        __dndTargetChannel =_channel;
    }
}