// Feather disable all

/// Returns the tab group ident for a tab group host or tab group button.
/// 
/// @param [instance=self]

function GuiTabGetIdent(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return undefined;
    
    return _instance.GUI_VARS.__tabIdent;
}