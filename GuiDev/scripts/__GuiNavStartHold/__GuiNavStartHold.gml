// Feather disable all

/// Starts the hold state for an instance.
/// 
/// @param instance

function __GuiNavStartHold(_instance)
{
    if (GUI_EXISTS(_instance) && (not GuiNavGetHold(_instance)))
    {
        with(_instance.GUI_VARS)
        {
            __holdState = GUI_PRESS;
            __layer.__holdInstance = _instance;
            
            if (not __updating)
            {
                __updating = true;
                array_push(__layer.__updateInstanceArray, _instance)
            }
        }
    }
}