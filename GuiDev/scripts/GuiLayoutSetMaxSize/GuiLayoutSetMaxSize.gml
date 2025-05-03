// Feather disable all

/// @param [width]
/// @param [height]
/// @param [element=self]

function GuiLayoutSetMaxSize(_width, _height, _element = self)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (_width != undefined)
        {
            if (__layoutWidthMax != _width)
            {
                __layoutWidthMax = _width;
                __layer.__layoutDirty = true;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightMax != _height)
            {
                __layoutHeightMax = _height;
                __layer.__layoutDirty = true;
            }
        }
    }
}