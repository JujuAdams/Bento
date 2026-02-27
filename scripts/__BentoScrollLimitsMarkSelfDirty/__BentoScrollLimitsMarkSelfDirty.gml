function __BentoScrollLimitsMarkSelfDirty()
{
    if ((__scrollHori || __scrollVert) && (not __scrollLimitsDirty))
    {
        __scrollLimitsDirty = true;
        array_push(__layer.__dirtyScrollLimitsArray, __attachedElement);
    }
}