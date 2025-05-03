// Feather disable all

/// @param instance

function __GuiMarkTransformAndScrollDirty(_element)
{
    if (not GUI_EXISTS(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (not __transformAndScrollDirty)
        {
            __transformAndScrollDirty = true;
            array_push(__layer.__transformAndScrollDirtyArray, _element);
        }
    }
}