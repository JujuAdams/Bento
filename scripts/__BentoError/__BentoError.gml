// Feather disable all

/// Library-specific error handler.
/// 
/// @param string

function __BentoError(_string)
{
    BENTO_SHOW_ERROR($"\n \nBento {BENTO_VERSION}:\n{_string}\n ", true);
}