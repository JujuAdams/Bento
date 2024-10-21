// Feather disable all

/// Sets the position and size of an instance. This function, unlike `GuiSetXYWH()`, will not move
/// the target instance's children.
/// 
/// @param x
/// @param y
/// @param width
/// @param height
/// @param [instance=id]

function GuiSetXYWHSolo(_x, _y, _width, _height, _instance = id)
{
    GuiSetPositionSolo(_x, _y, _instance);
    GuiSetSize(_width, _height, _instance);
}