// Feather disable all

/// @param instance

function __GuiNavStartOver(_instance)
{
    static _system = __GuiSystem();
    
    with(_system)
    {
        if (instance_exists(_instance))
        {
            if (__navMode == GUI_NAV_GAMEPAD)
            {
                __gamepadLastX = _instance.x;
                __gamepadLastY = _instance.y;
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