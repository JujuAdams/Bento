// Feather disable all

/// @param environment

function GuiEnvironmentDestroy(_environment)
{
    if (_environment == undefined) return;
    _environment.__Destroy();
}