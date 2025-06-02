// Feather disable all

/// @param instance

function __GuiMarkTransformDirty(_element)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (not __transformDirty)
        {
            __transformDirty = true;
            array_push(__layer.__dirtyTransformsArray, self);
        }
    }
}