// Feather disable all

/// Returns the tab group ident for a tab group host or tab group button.
/// 
/// @param [instance=id]

function GuiTabGetIdent(_instance = id)
{
    if (not instance_exists(_instance)) return undefined;
    
    return _instance.__tabIdent;
}