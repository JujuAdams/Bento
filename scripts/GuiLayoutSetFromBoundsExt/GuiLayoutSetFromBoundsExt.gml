// Feather disable all

/// @param instance
/// @param layout
/// @param padLeft
/// @param padTop
/// @param padRight
/// @param padBottom

function GuiLayoutSetFromBoundsExt(_instance, _layout, _padLeft, _padTop, _padRight, _padBottom)
{
    with(_instance)
    {
        var _bounds = GuiLayoutGetBoundsExt(_layout, _padLeft, _padTop, _padRight, _padBottom);
        x      = _bounds.x;
        y      = _bounds.y;
        width  = _bounds.width;
        height = _bounds.height;
    }
}