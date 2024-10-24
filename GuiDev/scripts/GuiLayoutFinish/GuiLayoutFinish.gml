// Feather disable all

/// Positions all instances that have been created in a layout with `GuiCreateInLayout()`.
/// 
/// @param layout
/// @param x
/// @param y

function GuiLayoutFinish(_layout, _x, _y)
{
    _layout.__Finish(_x, _y);
}