// Feather disable all

/// @param parent

function __GuiMarkChildOrderDirty(_parent)
{
    static _dirtyChildOrderArray = __GuiSystem().__dirtyChildOrderArray;
    
    if (not instance_exists(_parent)) return;
    
    if (not _parent.GUI_STRUCT.__childOrderDirty)
    {
        _parent.GUI_STRUCT.__childOrderDirty = true;
        array_push(_dirtyChildOrderArray, _parent);
    }
}