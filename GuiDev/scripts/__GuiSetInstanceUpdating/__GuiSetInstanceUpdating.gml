// Feather disable all

/// Sets an instance to "updating". This marks the instance to have its state updated in the
/// `__GuiUpdateInstanceState()` function.

function __GuiSetInstanceUpdating(_instance)
{
    static _updateInstanceArray = __GuiSystem().__updateInstanceArray;
    
    if (not instance_exists(_instance)) return;
    
    if (not _instance.GUI_STRUCT.__updating)
    {
        _instance.GUI_STRUCT.__updating = true;
        array_push(_updateInstanceArray, _instance)
    }
}