// Feather disable all

/// Returns a string, the friendly name of an over state constant.
/// 
/// @param behavior

function GuiFriendlyOverState(_behavior)
{
    switch(_behavior)
    {
        case GUI_OFF:   return "off";
        case GUI_ENTER: return "enter";
        case GUI_OVER:  return "over";
        case GUI_LEAVE: return "leave";
    }
    
    return "???"
}