// Feather disable all

/// Returns the bounding box that encompasses all children of the target element. The `padding`
/// parameter allows you to add space around the edge of the bounding box, applied equally in all
/// directions. A static struct is returned with the following member variables:
/// 
/// .x:      x-position of the middle of the bounding box
/// .y:      y-position of the middle of the bounding box
/// .width:  width of the bounding box
/// .height: height of the bounding box
/// .left:   x-position of the left of the bounding box
/// .top:    y-position of the top of the bounding box
/// .right:  x-position of the right of the bounding box
/// .bottom: y-position of the bottom of the bounding box
/// 
/// @param [padding=0]
/// @param [element=self]

function __BentoGetChildrenBounds(_padding = 0, _element = self)
{
    return __BentoGetChildrenBoundsExt(_padding, _padding, _padding, _padding, _element);
}