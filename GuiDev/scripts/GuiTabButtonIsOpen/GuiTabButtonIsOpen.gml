// Feather disable all

/// Returns whether the specified tab button has been opened. This can be used to show a different
/// graphic when a tab is open.
/// 
/// @param [instance=self]

function GuiTabButtonIsOpen(_instance = self)
{
    if (not GUI_EXISTS(_instance)) return false;
    
    var _tabIdent = _instance.GUI_VARS.__tabIdent;
    return (GuiTabIsOpen(_tabIdent) && (GuiTabGetButton(_tabIdent) == _instance));
}