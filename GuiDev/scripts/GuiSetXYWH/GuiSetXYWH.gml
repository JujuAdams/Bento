// Feather disable all

/// Sets the position and size of an instance. If that instance has any children (inside or
/// outside) then the children will follow the parent.
/// 
/// @param x
/// @param y
/// @param width
/// @param height
/// @param [instance=id]

function GuiSetXYWH(_x, _y, _width, _height, _instance = id)
{
    GuiSetPositionSolo(_x, _y, _instance);
    GuiSetSize(_width, _height, _instance);
}