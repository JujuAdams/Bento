// Feather disable all

/// @param [instance]

function GuiNavGetHold(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    return ((_instance.holdState == GUI_ENTER) || (_instance.holdState == GUI_HOLD));
}