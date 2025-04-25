// Feather disable all

/// @param instance

function __GuiMarkAnimAndScrollDirty(_instance)
{
    static _animAndScrollDirtyArray = __GuiSystem().__animAndScrollDirtyArray;
    
    if (not instance_exists(_instance)) return;
    
    if (not _instance.GUI_STRUCT.__animAndScrollDirty)
    {
        _instance.GUI_STRUCT.__animAndScrollDirty = true;
        array_push(_animAndScrollDirtyArray, _instance);
    }
}