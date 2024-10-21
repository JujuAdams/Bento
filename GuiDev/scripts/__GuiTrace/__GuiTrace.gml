// Feather disable all

/// Library-specific debug message handler.
/// 
/// @param string

function __GuiTrace(_string)
{
    static _system = __GuiSystem();
    
    if (GUI_SHOW_DEBUG_MESSAGE != undefined)
    {
        var _function = GUI_SHOW_DEBUG_MESSAGE;
        _function($"fr {string_format(_system.__frame, 6, 0)}   Gui: {_string}");
    }
}