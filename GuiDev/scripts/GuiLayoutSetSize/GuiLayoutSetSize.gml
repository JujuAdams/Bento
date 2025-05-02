// Feather disable all

/// @param [width]
/// @param [height]
/// @param [instance=self]

function GuiLayoutSetSize(_width, _height, _instance = self)
{
    if (not GUI_EXISTS(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (_width  != undefined)
        {
            if (__layoutWidthPref != _width)
            {
                __layoutWidthPref = _width;
                __environment.__layoutDirty = true;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightPref != _height)
            {
                __layoutHeightPref = _height;
                __environment.__layoutDirty = true;
            }
        }
    }
}