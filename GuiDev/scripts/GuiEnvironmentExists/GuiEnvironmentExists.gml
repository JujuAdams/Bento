// Feather disable all

/// @param environment

function GuiEnvironmentExists(_environment)
{
    static _environmentArray = __GuiSystem().__environmentArray;
    
    if (_environment == undefined) return false;
    return (array_get_index(_environmentArray, _environment) >= 0);
}