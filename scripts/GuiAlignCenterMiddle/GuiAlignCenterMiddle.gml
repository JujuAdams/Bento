// Feather disable all

/// Sets the absolute position of a GUI instance. If that instance has any children (inside or
/// outside) then the children will follow the parent.
/// 
/// @param instance
/// @param x
/// @param y
/// @param [relative=false]

function GuiAlignCenterMiddle(_instance, _x, _y, _relative = false)
{
    GuiSetPosition(_x, _y, _instance, _relative);
}