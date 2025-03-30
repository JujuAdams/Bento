// Feather disable all

/// @param path

function __GuiSanitizeFilename(_path)
{
    return string_replace_all(string(_path), "\\", "/");
}