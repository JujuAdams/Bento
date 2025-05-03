// Feather disable all

/// @param [width]
/// @param [height]
/// @param [element=self]

function GuiLayoutSetResizeType(_width, _height, _element = self)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (_width != undefined)
        {
            if (__layoutWidthResize != _width)
            {
                __layoutWidthResize = _width;
                __layer.__layoutDirty = true;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightResize != _height)
            {
                __layoutHeightResize = _height;
                __layer.__layoutDirty = true;
            }
        }
    }
}