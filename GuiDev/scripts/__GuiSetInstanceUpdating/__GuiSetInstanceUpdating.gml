// Feather disable all

/// Sets an instance to "updating". This marks the instance to have its state updated in the
/// `__GuiUpdateInstanceState()` function.

function __GuiSetInstanceUpdating(_instance)
{
    static _updateInstanceArray = __GuiSystem().__updateInstanceArray;
    
    if (not instance_exists(_instance)) return;
    
    if (not _instance.__gui.__updating)
    {
        _instance.__gui.__updating = true;
        array_push(_updateInstanceArray, _instance)
    }
}