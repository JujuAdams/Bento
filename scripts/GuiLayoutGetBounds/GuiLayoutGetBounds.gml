// Feather disable all

/// @param layout
/// @param padding

function GuiLayoutGetBounds(_layout, _padding)
{
    return GuiLayoutGetBoundsExt(_layout, _padding, _padding, _padding, _padding);
}