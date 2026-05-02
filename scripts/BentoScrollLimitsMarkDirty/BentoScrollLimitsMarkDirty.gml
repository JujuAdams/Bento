// Feather disable all

/// Marks an element's scroll limits as "dirty" meaning that they will be updated the next time
/// `BentoSystemStep()` is called. This function will rarely need to be called. It is provided for
/// situations where the library may not be able to detect changes that affect calculation of
/// scroll limits, such as changing the size of child elements.
/// 
/// @param element

function BentoScrollLimitsMarkDirty(_element)
{
    with(__BentoGetVars(_element))
    {
        __BentoScrollLimitsMarkSelfDirty();
    }
}