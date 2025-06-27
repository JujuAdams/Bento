// Feather disable all

/// @param [width]
/// @param [height]
/// @param [element=self]

function BentoLayoutSetResizeType(_width, _height, _element = self)
{
    if (not BentoExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (_width != undefined)
        {
            if (__layoutWidthResize != _width)
            {
                __layoutWidthResize = _width;
                __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightResize != _height)
            {
                __layoutHeightResize = _height;
                __layer.__dirtyFlags |= __GUI_DIRTY_LAYOUT;
            }
        }
    }
}