// Feather disable all

/// Marks an element's scroll limits as "dirty" meaning that they will be updated the next time
/// `BentoSystemStep()` is called. This function will rarely need to be called. It is provided for
/// situations where the library may not be able to detect changes that affect calculation of
/// scroll limits, such as changing the size of child elements.
/// 
/// @param element

function BentoScrollLimitsMarkDirty(_element)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if ((not __scrollHori) && (not __scrollVert)) return;
        
        if (not __scrollLimitsDirty)
        {
            __scrollLimitsDirty = true;
            array_push(__layer.__dirtyScrollLimitsArray, _element);
        }
    }
}