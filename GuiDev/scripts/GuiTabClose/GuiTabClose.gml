// Feather disable all

/// Destroys the tab instance currently opened in a tab group.
/// 
/// @param tabIdent

function GuiTabClose(_tabIdent)
{
    GuiDestroy(GuiTabGetChild(_tabIdent));
}