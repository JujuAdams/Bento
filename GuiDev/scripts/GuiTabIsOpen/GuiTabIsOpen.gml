// Feather disable all

/// Returns whether a tab is open in a tab group.
/// 
/// @param tabIdent

function GuiTabIsOpen(_tabIdent)
{
    return instance_exists(GuiTabGetChild(_tabIdent));
}