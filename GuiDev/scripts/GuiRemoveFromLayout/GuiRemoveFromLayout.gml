// Feather disable all

/// @param [instance=id]

function GuiRemoveFromLayout(_instance = id)
{
    if (not instance_exists(_instance)) return;
    
    if (_instance.__layout != undefined)
    {
        _instance.__layout.__Remove(_instance);
    }
}