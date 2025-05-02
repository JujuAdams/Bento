// Feather disable all

/// @param instance

function __GuiMarkTransformAndScrollDirty(_instance)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
    {
        if (not __transformAndScrollDirty)
        {
            __transformAndScrollDirty = true;
            array_push(__environment.__transformAndScrollDirtyArray, _instance);
        }
    }
}