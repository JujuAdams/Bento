// Feather disable all

/// @param [width]
/// @param [height]
/// @param [instance=id]

function GuiLayoutSetMinSize(_width, _height, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (_width != undefined)
        {
            if (__layoutWidthMin != _width)
            {
                __layoutWidthMin = _width;
                _system.__layoutDirty = true;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightMin != _height)
            {
                __layoutHeightMin = _height;
                _system.__layoutDirty = true;
            }
        }
    }
}