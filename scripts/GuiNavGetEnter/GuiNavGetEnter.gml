// Feather disable all

/// @param [instance]

function GuiNavGetEnter(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    return (_instance.overState == GUI_ENTER);
}