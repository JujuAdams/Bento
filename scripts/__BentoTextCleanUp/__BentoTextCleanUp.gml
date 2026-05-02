// Feather disable all

/// @param string

function __BentoTextCleanUp(_string)
{
    _string = string_replace_all(_string, chr(0x0A), ""); //line feed
    _string = string_replace_all(_string, chr(0x0D), ""); //carriage return
    _string = string_replace_all(_string, chr(0x7F), ""); //ctrl + del
    return _string;
}