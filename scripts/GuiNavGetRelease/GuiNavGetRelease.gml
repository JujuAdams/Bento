// Feather disable all

/// @param [instance]

function GuiNavGetRelease(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    return (_instance.holdState == GUI_RELEASE);
}