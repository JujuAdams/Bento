// Feather disable all

/// @param axis
/// @param [element=self]

function BentoLayoutSetListAxis(_axis, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if ((_axis != undefined) && (__listAxis != _axis))
        {
            __listAxis = _axis;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
    }
}