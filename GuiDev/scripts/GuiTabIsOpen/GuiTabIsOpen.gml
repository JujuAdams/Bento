// Feather disable all

/// Returns whether a tab is open.
/// 
/// @param tabIdent

function GuiTabIsOpen(_tabIdent)
{
    return instance_exists(GuiTabGetChild(_tabIdent));
}