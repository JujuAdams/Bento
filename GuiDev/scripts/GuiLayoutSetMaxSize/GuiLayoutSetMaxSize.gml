// Feather disable all

/// @param [width]
/// @param [height]
/// @param [instance=id]

function GuiLayoutSetMaxSize(_width, _height, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_VARS)
    {
        if (_width != undefined)
        {
            if (__layoutWidthMax != _width)
            {
                __layoutWidthMax = _width;
                __environment.__layoutDirty = true;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightMax != _height)
            {
                __layoutHeightMax = _height;
                __environment.__layoutDirty = true;
            }
        }
    }
}