// Feather disable all

/// @param [width]
/// @param [height]
/// @param [instance=self]

function GuiLayoutSetMinSize(_width, _height, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
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