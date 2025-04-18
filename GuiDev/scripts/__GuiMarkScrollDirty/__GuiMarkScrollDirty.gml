// Feather disable all

/// @param parent

function GuiScrollLimitsMarkDirty(_parent)
{
    static _dirtyScrollLimitsArray = __GuiSystem().__dirtyScrollLimitsArray;
    
    if (not instance_exists(_parent)) return;
    
    if (not (variable_instance_get(_parent, "__scrollLimitsDirty") ?? false))
    {
        _parent.__scrollLimitsDirty = true;
        array_push(_dirtyScrollLimitsArray, _parent);
    }
}