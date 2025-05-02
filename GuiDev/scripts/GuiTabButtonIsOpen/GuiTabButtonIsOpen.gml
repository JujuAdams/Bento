// Feather disable all

/// Returns whether the specified tab button has been opened. This can be used to show a different
/// graphic when a tab is open.
/// 
/// @param [instance=id]

function GuiTabButtonIsOpen(_instance = id)
{
    if (not instance_exists(_instance)) return false;
    
    var _tabIdent = _instance.GUI_VARS.__tabIdent;
    return (GuiTabIsOpen(_tabIdent) && (GuiTabGetButton(_tabIdent) == _instance));
}