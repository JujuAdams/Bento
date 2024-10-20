// Feather disable all

/// @param layout
/// @param padLeft
/// @param padTop
/// @param padRight
/// @param padBottom
/// @param [instance=id]

function GuiSetSizeAroundLayoutExt(_layout, _padLeft, _padTop, _padRight, _padBottom, _instance = id)
{
    var _bounds = GuiLayoutGetBoundsExt(_layout, _padLeft, _padTop, _padRight, _padBottom);
    GuiSetXYWHSolo(_instance, _bounds.x, _bounds.y, _bounds.width, _bounds.height);
}