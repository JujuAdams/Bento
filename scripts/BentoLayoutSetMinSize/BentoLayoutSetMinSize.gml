// Feather disable all

/// Sets the minimum size for an element. An element will never be set to a size smaller than this
/// even if it results in overlaps. A value of zero (or less) will be treated as "no minimum set"
/// and Bento will use the width/height set by `BentoLayoutSetSize()` as the minimum size instead.
/// This is also the default behaviour.
/// 
/// @param [width]
/// @param [height]
/// @param [element=self]

function BentoLayoutSetMinSize(_width, _height, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (_width != undefined)
        {
            if (__layoutWidthMin != _width)
            {
                __layoutWidthMin = _width;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightMin != _height)
            {
                __layoutHeightMin = _height;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}