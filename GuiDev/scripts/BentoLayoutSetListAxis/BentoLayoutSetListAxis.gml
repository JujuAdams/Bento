// Feather disable all

/// @param axis
/// @param [element=self]

function BentoLayoutSetListAxis(_axis, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__layoutType != BENTO_LAYOUT_LIST)
        {
            __BentoError("Can only apply list axis to elements using a list layout");
        }
        
        if (__listAxis != _axis)
        {
            __listAxis = _axis;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
    }
}