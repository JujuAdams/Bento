// Feather disable all

/// @param element

function __BentoMarkTransformDirty(_element)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (not __transformDirty)
        {
            __transformDirty = true;
            array_push(__layer.__dirtyTransformsArray, self);
        }
    }
}