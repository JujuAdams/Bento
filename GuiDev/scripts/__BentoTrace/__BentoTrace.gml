// Feather disable all

/// Library-specific debug message handler.
/// 
/// @param string

function __BentoTrace(_string)
{
    static _system = __BentoSystem();
    
    if (BENTO_SHOW_DEBUG_MESSAGE != undefined)
    {
        var _function = BENTO_SHOW_DEBUG_MESSAGE;
        _function($"fr {string_format(_system.__frame, 6, 0)}   Bento: {_string}");
    }
}