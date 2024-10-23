// Feather disable all

/// Destroys the tab instance currently opened by a host.
/// 
/// @param tabIdent

function GuiTabClose(_tabIdent)
{
    GuiDestroy(GuiTabGetChild(_tabIdent));
}