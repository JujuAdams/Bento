// Feather disable all

/// @param environmentOrName

function GuiEnvironmentExists(_environmentOrName)
{
    static _environmentArray = __GuiSystem().__environmentArray;
    
    if (is_string(_environmentOrName))
    {
        var _environment = GuiEnvironmentFind(_environmentOrName);
    }
    else if (is_struct(_environmentOrName))
    {
        var _environment = _environmentOrName;
    }
    else
    {
        return false
    }
    
    return (array_get_index(_environmentArray, _environment) >= 0);
}