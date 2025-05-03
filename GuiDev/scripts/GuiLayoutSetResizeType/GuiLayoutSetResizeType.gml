// Feather disable all

/// @param [width]
/// @param [height]
/// @param [instance=self]

function GuiLayoutSetResizeType(_width, _height, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
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