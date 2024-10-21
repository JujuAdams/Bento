// Feather disable all

/// Returns a static struct containing the bounding box for members of a layout. The `padding`
/// parameter allows you to adding spacing around the edge of member instances, applied equally in
/// all directions. The returned struct will contain the following member variables:
/// 
/// .x:      x-position of the center of the bounding box
/// .y:      y-position of the center of the bounding box
/// .width:  width of the bounding box
/// .height: height of the bounding box
/// 
/// @param layout
/// @param padding

function GuiLayoutGetBounds(_layout, _padding)
{
    return GuiLayoutGetBoundsExt(_layout, _padding, _padding, _padding, _padding);
}