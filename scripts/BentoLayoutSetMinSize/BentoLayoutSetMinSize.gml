// Feather disable all

/// Sets the minimum size for an element. An element will never be set to a size smaller than this
/// even if it results in overlaps.
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