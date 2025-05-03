// Feather disable all

/// @param environmentOrName

function GuiEnvironmentDestroy(_environmentOrName)
{
    if (is_string(_environmentOrName))
    {
        var _environment = GuiEnvironmentFind(_environmentOrName);
    }
    else if (is_struct(_environmentOrName))
    {
        var _environment = _environmentOrName;
    }
    
    if (not is_struct(_environment)) return;
    
    _environment.__Destroy();
}