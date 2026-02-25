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
///     Element will reduce size to tightly fit around its children, leaving no extra space.
/// 
/// `BENTO_RESIZE_ASPECT`
///     Element will set its height relative to its width keeping the aspect ratio set by the
///     baseline dimensions (as set by `BentoLayoutSetSize()`). This resize logic can only be used
///     for the `height` parameter. This mode should be used sparingly because it can create ugly
///     layouts.
/// 
/// You may also pass `undefined` for either parameter to indicate that the existing value should
/// not be changed.
/// 
/// @param [width]
/// @param [height]
/// @param [element=self]

function BentoLayoutSetResize(_width, _height, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if ((_width != undefined) && (__layoutWidthResize != _width))
        {
            if (_width == BENTO_RESIZE_ASPECT)
            {
                __BentoError("Cannot use `BENTO_RESIZE_ASPECT` for x-axis resize");
            }
            
            __layoutWidthResize = _width;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
        
        if ((_height != undefined) && (__layoutHeightResize != _height))
        {
            __layoutHeightResize = _height;
            __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
        }
    }
}