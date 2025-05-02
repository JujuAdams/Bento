// Feather disable all

/// @param [width]
/// @param [height]
/// @param [instance=id]

function GuiLayoutSetMinSize(_width, _height, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (_width != undefined)
        {
            if (__layoutWidthMin != _width)
            {
                __layoutWidthMin = _width;
                __environment.__layoutDirty = true;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightMin != _height)
            {
                __layoutHeightMin = _height;
                __environment.__layoutDirty = true;
            }
        }
    }
}