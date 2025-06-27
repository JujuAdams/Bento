// Feather disable all

/// @param [x]
/// @param [y]
/// @param [element=self]

function BentoLayoutSetOrigin(_x, _y, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (__layoutOriginAuto)
        {
            __layoutOriginAuto = false;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
        
        if (_x != undefined)
        {
            if (__layoutOriginX != _x)
            {
                __layoutOriginX = _x;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
        
        if (_y != undefined)
        {
            if (__layoutOriginY != _y)
            {
                __layoutOriginY = _y;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}