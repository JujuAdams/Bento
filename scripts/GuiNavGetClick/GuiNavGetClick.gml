// Feather disable all

/// @param [instance]

function GuiNavGetClick(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    return _instance.click;
}