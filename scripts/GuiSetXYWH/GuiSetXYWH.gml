// Feather disable all

/// @param instance
/// @param x
/// @param y
/// @param width
/// @param height

function GuiSetXYWH(_instance, _x, _y, _width, _height)
{
    with(_instance)
    {
        GuiMove(_instance, _x, _y);
        
        width  = _width;
        height = _height;
    }
}