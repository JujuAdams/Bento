// Feather disable all

/// @param channel
/// @param [element=self]

function BentoCarrySetTargetChannel(_channel, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__carryTargetChannel != _channel)
        {
            __layer.__dirtyFlags |= __BENTO_DIRTY_HOVERABLE;
            __carryTargetChannel =_channel;
        }
    }
}