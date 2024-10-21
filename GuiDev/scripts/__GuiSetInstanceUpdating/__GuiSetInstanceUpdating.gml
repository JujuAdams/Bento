// Feather disable all

/// Sets an instance to "updating". This marks the instance to have its state updated in the
/// `__GuiUpdateInstanceState()` function.

function __GuiSetInstanceUpdating(_instance)
{
    static _updateInstanceArray = __GuiSystem().__updateInstanceArray;
    
    if (not _instance.__updating)
    {
        _instance.__updating = true;
        array_push(_updateInstanceArray, _instance)
    }
}