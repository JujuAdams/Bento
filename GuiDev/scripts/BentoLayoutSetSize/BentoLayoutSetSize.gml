// Feather disable all

/// Sets the baseline size for an element. If an element's resize type is `BENTO_RESIZE_STATIC`
/// this size will be used as the size for the element.
/// 
/// @param [width]
/// @param [height]
/// @param [element=self]

function BentoLayoutSetSize(_width, _height, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (_width != undefined)
        {
            if (__layoutWidthPref != _width)
            {
                __layoutWidthPref = _width;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightPref != _height)
            {
                __layoutHeightPref = _height;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}