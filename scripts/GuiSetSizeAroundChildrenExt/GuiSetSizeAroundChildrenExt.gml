// Feather disable all

/// @param padLeft
/// @param padTop
/// @param padRight
/// @param padBottom
/// @param [instance=id]

function GuiSetSizeAroundChildrenExt(_padLeft, _padTop, _padRight, _padBottom, _instance = id)
{
    var _bounds = GuiGetChildrenBoundsExt(_padLeft, _padTop, _padRight, _padBottom, _instance);
    GuiSetXYWHSolo(_instance, _bounds.x, _bounds.y, _bounds.width, _bounds.height);
}