// Feather disable all

/// @param [width]
/// @param [height]
/// @param [element=self]

function GuiLayoutSetSize(_width, _height, _element = self)
{
    if (not GUI_EXISTS(_element)) return;
    
    with(_element.GUI_VARS)
    {
        if (_width  != undefined)
        {
            if (__layoutWidthPref != _width)
            {
                __layoutWidthPref = _width;
                __layer.__layoutDirty = true;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightPref != _height)
            {
                __layoutHeightPref = _height;
                __layer.__layoutDirty = true;
            }
        }
    }
}