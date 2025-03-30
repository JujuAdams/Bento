// Feather disable all

/// @param [width]
/// @param [height]
/// @param [instance=id]

function GuiSetLayoutSize(_width, _height, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (_width  != undefined)
        {
            if (__layoutWidthPref != _width)
            {
                __layoutWidthPref = _width;
                _system.__layoutDirty = true;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightPref != _height)
            {
                __layoutHeightPref = _height;
                _system.__layoutDirty = true;
            }
        }
    }
}