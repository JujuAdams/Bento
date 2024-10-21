// Feather disable all

/// Library-specific error handler.
/// 
/// @param string

function __GuiError(_string)
{
    GUI_SHOW_ERROR($"\n \nGui {GUI_VERSION}:\n{_string}\n ", true);
}