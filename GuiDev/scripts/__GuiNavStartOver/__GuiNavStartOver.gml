// Feather disable all

/// Starts the over state for an instance.
/// 
/// @param instance

function __GuiNavStartOver(_instance)
{
    if (GUI_EXISTS(_instance))
    {
        if (__navMode == GUI_NAV_DIRECTIONAL)
        {
            __directionalLastX = _instance.x;
            __directionalLastY = _instance.y;
            GuiScrollTo(undefined, _instance);
        }
        
        __overInstance = _instance;
        
        with(_instance.GUI_VARS)
        {
            if (not __updating)
            {
                __updating = true;
                array_push(__layer.__updateInstanceArray, _instance)
            }
        }
    }
    else
    {
        __overInstance = noone;
    }
    
    __overInstanceSoft = noone;
}