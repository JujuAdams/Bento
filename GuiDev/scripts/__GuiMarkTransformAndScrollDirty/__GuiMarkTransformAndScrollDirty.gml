// Feather disable all

/// @param instance

function __GuiMarkTransformAndScrollDirty(_instance)
{
    static _transformAndScrollDirtyArray = __GuiSystem().__transformAndScrollDirtyArray;
    
    if (not instance_exists(_instance)) return;
    
    if (not _instance.GUI_STRUCT.__transformAndScrollDirty)
    {
        _instance.GUI_STRUCT.__transformAndScrollDirty = true;
        array_push(_transformAndScrollDirtyArray, _instance);
    }
}