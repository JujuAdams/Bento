// Feather disable all

/// @param string

function __GuiTrace(_string)
{
    static _system = __GuiSystem();
    
    GUI_SHOW_DEBUG_MESSAGE($"fr {string_format(_system.__frame, 6, 0)}   Gui: {_string}");
}