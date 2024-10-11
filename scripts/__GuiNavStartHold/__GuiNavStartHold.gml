// Feather disable all

/// @param instance

function __GuiNavStartHold(_instance)
{
    static _system = __GuiSystem();
    
    if (instance_exists(_instance) && (not GuiNavGetHold(_instance)))
    {
        _instance.holdState = GUI_PRESS;
        _system.__holdInstance = _instance;
        __GuiSetInstanceUpdating(_instance);
    }
}