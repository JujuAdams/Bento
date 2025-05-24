// Feather disable all

/// @param environment

function GuiEnvironmentDestroy(_environment)
{
    if (not is_struct(_environment)) return;
    
    _environment.__Destroy();
}