// Feather disable all

/// @param [x]
/// @param [y]
/// @param [element=self]

function BentoLayoutSetGutter(_x, _y, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if ((__layoutType != BENTO_LAYOUT_LIST) && (__layoutType != BENTO_LAYOUT_GRID))
        {
            __BentoError("Can only apply gutter to elements using a list or grid layout");
        }
        
        if (_x != undefined)
        {
            if (__layoutGutterX != _x)
            {
                __layoutGutterX = _x;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
        
        if (_y != undefined)
        {
            if (__layoutGutterY != _y)
            {
                __layoutGutterY = _y;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}