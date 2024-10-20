// Feather disable all

/// @param width
/// @param height
/// @param [instance=id]

function GuiSetSize(_width, _height, _instance = id)
{
    with(_instance)
    {
        width  = _width;
        height = _height;
    }
}