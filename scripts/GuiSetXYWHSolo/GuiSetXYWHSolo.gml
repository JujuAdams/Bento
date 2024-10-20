// Feather disable all

/// @param instance
/// @param x
/// @param y
/// @param width
/// @param height

function GuiSetXYWHSolo(_instance, _x, _y, _width, _height)
{
    with(_instance)
    {
        GuiSetPositionSolo(_x, _y, _instance);
        
        width  = _width;
        height = _height;
    }
}