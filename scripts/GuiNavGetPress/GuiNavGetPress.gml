// Feather disable all

/// @param [instance]

function GuiNavGetPress(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    return (_instance.holdState == GUI_PRESS);
}