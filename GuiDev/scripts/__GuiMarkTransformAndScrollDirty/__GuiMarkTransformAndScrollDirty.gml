// Feather disable all

/// @param instance

function __GuiMarkTransformAndScrollDirty(_instance)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (not __transformAndScrollDirty)
        {
            __transformAndScrollDirty = true;
            array_push(__layer.__transformAndScrollDirtyArray, _instance);
        }
    }
}