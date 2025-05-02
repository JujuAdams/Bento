// Feather disable all

/// Marks an instance's scroll limits as "dirty" meaning that they will be updated the next time
/// `GuiStep()` is called. This function will rarely need to be called. It is provided for
/// situations where the library may not be able to detect changes that affect calculation of
/// scroll limits.
/// 
/// @param instance

function GuiScrollLimitsMarkDirty(_instance)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
    {
        if ((not __scrollHori) && (not __scrollVert)) return;
        
        if (not __scrollLimitsDirty)
        {
            __scrollLimitsDirty = true;
            array_push(__environment.__dirtyScrollLimitsArray, _instance);
        }
    }
}