// Feather disable all

/// @param instance
/// @param layout
/// @param padding

function GuiLayoutSetFromBounds(_instance, _layout, _padding)
{
    with(_instance)
    {
        var _bounds = GuiLayoutGetBounds(_layout, _padding);
        x      = _bounds.x;
        y      = _bounds.y;
        width  = _bounds.width;
        height = _bounds.height;
    }
}