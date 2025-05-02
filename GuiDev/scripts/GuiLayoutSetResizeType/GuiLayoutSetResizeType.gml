// Feather disable all

/// @param [width]
/// @param [height]
/// @param [instance=id]

function GuiLayoutSetResizeType(_width, _height, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
    {
        if (_width != undefined)
        {
            if (__layoutWidthResize != _width)
            {
                __layoutWidthResize = _width;
                __environment.__layoutDirty = true;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightResize != _height)
            {
                __layoutHeightResize = _height;
                __environment.__layoutDirty = true;
            }
        }
    }
}