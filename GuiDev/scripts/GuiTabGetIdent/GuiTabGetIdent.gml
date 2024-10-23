// Feather disable all

/// @param [instance=id]

function GuiTabGetIdent(_instance = id)
{
    if (not instance_exists(_instance)) return undefined;
    
    return _instance.__tabIdent;
}