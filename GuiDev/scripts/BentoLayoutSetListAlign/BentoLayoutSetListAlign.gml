// Feather disable all

/// @param [horizontal]
/// @param [vertical]
/// @param [element=self]

function BentoLayoutSetListAlign(_horizontal, _vertical, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__layoutType != BENTO_LAYOUT_LIST)
        {
            __BentoError("Can only set list child alignment for elements using a list layout");
        }
        
        if (_horizontal != undefined)
        {
            if (__layoutHAlignChildren != _horizontal)
            {
                __layoutHAlignChildren = _horizontal;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
        
        if (_vertical != undefined)
        {
            if (__layoutVAlignChildren != _vertical)
            {
                __layoutVAlignChildren = _vertical;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}