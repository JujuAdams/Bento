// Feather disable all

/// Sets the drag & drop channel for the specified element.
/// 
/// @param channel
/// @param [element=self]

function BentoCarrySetItemChannel(_channel, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__carryItemChannel != _channel)
        {
            __layer.__dirtyFlags |= __BENTO_DIRTY_HOVERABLE;
            __carryItemChannel =_channel;
        }
    }
}