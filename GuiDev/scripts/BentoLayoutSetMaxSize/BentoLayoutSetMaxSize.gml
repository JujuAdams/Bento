// Feather disable all

/// @param [width]
/// @param [height]
/// @param [element=self]

function BentoLayoutSetMaxSize(_width, _height, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.BENTO_VARS)
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