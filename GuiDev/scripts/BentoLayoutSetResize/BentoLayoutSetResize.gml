// Feather disable all

/// Sets the resizing logic for an element.
/// 
/// N.B. Regardless of the resizing logic set by this function, elements will always attempt to
//       reduce in size, down to their minimum size, if they are too big for their parent.
/// 
/// The `width` and `height` parameters should be one of the following values:
/// 
/// `BENTO_RESIZE_NORMAL`
///     Element does nothing extra and keeps the same size (provided it fits inside the parent).
/// 
/// `BENTO_RESIZE_INFLATE`
///     Element will try to increase in size to fill available space.
/// 
/// `BENTO_RESIZE_DEFLATE`
///     Element will reduce size to tightly fit all of its children, leaving no extra space.
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