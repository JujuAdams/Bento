// Feather disable all

/// Returns a string, the friendly name of a hold state constant.
/// 
/// @param behavior

function GuiFriendlyHoldState(_behavior)
{
    switch(_behavior)
    {
        case GUI_OFF:     return "off";
        case GUI_PRESS:   return "press";
        case GUI_HOLD:    return "hold";
        case GUI_RELEASE: return "release";
    }
    
    return "???"
}