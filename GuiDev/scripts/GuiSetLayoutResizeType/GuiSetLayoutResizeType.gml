// Feather disable all

/// @param [width]
/// @param [height]
/// @param [instance=id]

function GuiSetLayoutResizeType(_width, _height, _instance = id)
{
    static _system = __GuiSystem();
    
    with(_instance)
    {
        if (_width != undefined)
        {
            if (__layoutWidthResize != _width)
            {
                __layoutWidthResize = _width;
                _system.__layoutDirty = true;
            }
        }
        
        if (_height != undefined)
        {
            if (__layoutHeightResize != _height)
            {
                __layoutHeightResize = _height;
                _system.__layoutDirty = true;
            }
        }
    }
}