// Feather disable all

/// Must be called in the scope of the `BENTO_VARS` for the dirtied element.

function __BentoMarkTransformDirty()
{
    if (not __transformDirty)
    {
        __transformDirty = true;
        array_push(__layer.__dirtyTransformsArray, self);
    }
}