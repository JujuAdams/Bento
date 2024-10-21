// Feather disable all

/// Sets the position and size of an instance to encapsulate of its children (including "outside"
/// children). The `padding` parameter adds space around the edges of the children.
/// 
/// @param padLeft
/// @param padTop
/// @param padRight
/// @param padBottom
/// @param [instance=id]

function GuiSetSizeAroundChildrenExt(_padLeft, _padTop, _padRight, _padBottom, _instance = id)
{
    var _bounds = GuiGetChildrenBoundsExt(_padLeft, _padTop, _padRight, _padBottom, _instance);
    GuiSetXYWHSolo(_bounds.x, _bounds.y, _bounds.width, _bounds.height, _instance);
}