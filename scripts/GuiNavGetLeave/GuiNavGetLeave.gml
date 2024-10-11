// Feather disable all

/// @param [instance]

function GuiNavGetLeave(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    return (_instance.overState == GUI_LEAVE);
}