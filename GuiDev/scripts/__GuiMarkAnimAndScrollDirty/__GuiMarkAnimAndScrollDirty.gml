// Feather disable all

/// @param instance

function __GuiMarkAnimAndScrollDirty(_instance)
{
    static _animAndScrollDirtyArray = __GuiSystem().__animAndScrollDirtyArray;
    
    if (not instance_exists(_instance)) return;
    
    if (not _instance.__animAndScrollDirty)
    {
        _instance.__animAndScrollDirty = true;
        array_push(_animAndScrollDirtyArray, _instance);
    }
}