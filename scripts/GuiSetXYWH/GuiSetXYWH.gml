// Feather disable all

/// @param instance
/// @param x
/// @param y
/// @param width
/// @param height
/// @param [moveChildren=true]

function GuiSetXYWH(_instance, _x, _y, _width, _height, _moveChildren = true)
{
    with(_instance)
    {
        GuiSetPosition(_x, _y, _instance, undefined);
        
        width  = _width;
        height = _height;
    }
}