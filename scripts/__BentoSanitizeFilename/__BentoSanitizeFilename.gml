// Feather disable all

/// @param path

function __BentoSanitizeFilename(_path)
{
    return string_replace_all(string(_path), "\\", "/");
}