// Feather disable all

/// Marks an instance's scroll limits as "dirty" meaning that they will be updated the next time
/// `GuiSystemStep()` is called. This function will rarely need to be called. It is provided for
/// situations where the library may not be able to detect changes that affect calculation of
/// scroll limits, such as changing the size of child elements.
/// 
/// @param instance

function GuiScrollLimitsMarkDirty(_element)
{
    if (not GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if ((not __scrollHori) && (not __scrollVert)) return;
        
        if (not __scrollLimitsDirty)
        {
            __scrollLimitsDirty = true;
            array_push(__layer.__dirtyScrollLimitsArray, _element);
        }
    }
}