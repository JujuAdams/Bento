// Feather disable all

/// Library-specific error handler.
/// 
/// @param string

function __BentoError(_string)
{
    GUI_SHOW_ERROR($"\n \nBento {GUI_VERSION}:\n{_string}\n ", true);
}