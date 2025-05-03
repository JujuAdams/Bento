// Feather disable all

/// @param instance

function __GuiMarkTransformAndScrollDirty(_element)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (not __transformAndScrollDirty)
        {
            __transformAndScrollDirty = true;
            array_push(__layer.__transformAndScrollDirtyArray, _element);
        }
    }
}