// Feather disable all

/// Starts the over state for an instance.
/// 
/// @param instance

function __GuiNavStartOver(_instance)
{
    static _system = __GuiSystem();
    
    with(_system)
    {
        if (instance_exists(_instance))
        {
            if (__navMode == GUI_NAV_DIRECTIONAL)
            {
                __directionalLastX = _instance.x;
                __directionalLastY = _instance.y;
                GuiScrollTo(_instance);
            }
            
            __overInstance = _instance;
            __GuiSetInstanceUpdating(_instance);
        }
        else
        {
            __overInstance = noone;
        }
        
        __overInstanceSoft = noone;
    }
}