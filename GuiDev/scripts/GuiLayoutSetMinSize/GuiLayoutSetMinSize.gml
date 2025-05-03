// Feather disable all

/// @param [width]
/// @param [height]
/// @param [element=self]

function GuiLayoutSetMinSize(_width, _height, _element = self)
{
    if (not __GuiExists(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (_width != undefined)
        {
            if (__layoutWidthMin != _width)
            {
                __layoutWidthMin = _width;
                __layer.__layoutDirty = true;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightMin != _height)
            {
                __layoutHeightMin = _height;
                __layer.__layoutDirty = true;
            }
        }
    }
}