// Feather disable all

/// Sets the resizing logic for an element. The `width` and `height` parameters should be one of
/// the following values:
/// 
/// `BENTO_RESIZE_STATIC`
///     Element won't resize.
/// 
/// `BENTO_RESIZE_GROW`
///     Element will increase in size in the axis to fill any available space in the parent.
/// 
/// `BENTO_RESIZE_SHRINK`
///     Element will reduce size to fit all of its children with no extra space.
/// 
/// You may also pass `undefined` for either parameter to indicate that the existing value should
/// not be changed.
/// 
/// @param [width]
/// @param [height]
/// @param [element=self]

function BentoLayoutSetResize(_width, _height, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
    {
        if (_width != undefined)
        {
            if (__layoutWidthResize != _width)
            {
                __layoutWidthResize = _width;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightResize != _height)
            {
                __layoutHeightResize = _height;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}