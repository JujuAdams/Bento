// Feather disable all

/// Sets the position and size of an instance to encapsulate of all members of a layout. The
/// `padding` parameter adds space around the edges of the member instances.
/// 
/// @param layout
/// @param padLeft
/// @param padTop
/// @param padRight
/// @param padBottom
/// @param [instance=id]

function GuiSetSizeAroundLayoutExt(_layout, _padLeft, _padTop, _padRight, _padBottom, _instance = id)
{
    var _bounds = GuiLayoutGetBoundsExt(_layout, _padLeft, _padTop, _padRight, _padBottom);
    GuiSetXYWHSolo(_bounds.x, _bounds.y, _bounds.width, _bounds.height, _instance);
}