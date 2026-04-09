// Feather disable all

/// @param channel
/// @param [element=self]

function BentoDnDSetTargetChannel(_channel, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__dndTargetChannel != _channel)
        {
            __layer.__dirtyFlags |= __BENTO_DIRTY_HOVERABLE;
            __dndTargetChannel =_channel;
        }
    }
}