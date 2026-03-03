/// Must be called from within BENTO_VARS

function __BentoOffsetMarkDirty()
{
    if (not __offsetDirty)
    {
        __offsetDirty = true;
        array_push(__layer.__dirtyOffsetArray, __attachedElement);
    }
}