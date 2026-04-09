// Feather disable all

/// Sets the drag & drop channel for the specified element.
/// 
/// @param channel
/// @param [element=self]

function BentoDnDSetItemChannel(_channel, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (__dndItemChannel != _channel)
        {
            __layer.__dirtyFlags |= __BENTO_DIRTY_HOVERABLE;
            __dndItemChannel =_channel;
        }
    }
}