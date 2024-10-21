// Feather disable all

/// Returns a string, the friendly name of a behavior constant.
/// 
/// @param behavior

function GuiFriendlyBehavior(_behavior)
{
    switch(_behavior)
    {
        case GUI_BEHAVIOR_COSMETIC:       return "cosmetic";
        case GUI_BEHAVIOR_BUTTON:         return "button";
        case GUI_BEHAVIOR_LISTENER:       return "listener";
        case GUI_BEHAVIOR_MODAL:          return "modal";
        case GUI_BEHAVIOR_POP_UP:         return "pop-up";
        case GUI_BEHAVIOR_BLOCK_SIBLINGS: return "block siblings";
    }
    
    return "???"
}