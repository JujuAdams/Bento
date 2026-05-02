// Feather disable all

/// Sets the maximum size for an element. An element will never be set to a size larger than this
/// even if there is extra space for the element to fill.
/// 
/// @param [width]
/// @param [height]
/// @param [element=self]

function BentoLayoutSetMaxSize(_width, _height, _element = self)
{
    with(__BentoGetVars(_element))
    {
        if (_width != undefined)
        {
            if (__layoutWidthMax != _width)
            {
                __layoutWidthMax = _width;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightMax != _height)
            {
                __layoutHeightMax = _height;
                __layer.__dirtyFlags |= __BENTO_DIRTY_LAYOUT;
            }
        }
    }
}