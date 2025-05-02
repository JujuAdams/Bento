// Feather disable all

/// @param [width]
/// @param [height]
/// @param [instance=id]

function GuiLayoutSetSize(_width, _height, _instance = id)
{
    if (not instance_exists(_instance)) return;
    
    with(_instance.GUI_STRUCT)
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