// Feather disable all

/// Starts the hold state for an instance.
/// 
/// @param instance

function __GuiNavStartHold(_instance)
{
    static _system = __GuiSystem();
    
    if (instance_exists(_instance) && (not GuiNavGetHold(_instance)))
    {
        _instance.__holdState = GUI_PRESS;
        _system.__holdInstance = _instance;
        __GuiSetInstanceUpdating(_instance);
    }
}