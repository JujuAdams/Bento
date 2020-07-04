/// @function __bento_point_in_aabb(x, y)
/// @param x
/// @param y
function __bento_point_in_aabb(_x, _y)
{
    //Use the clipping window and our AABB to determine if the mouse is over this element
    var _bbox = property.bbox_base;
    if (point_in_rectangle(_x, _y, bento_clip.l, bento_clip.t, bento_clip.r, bento_clip.b)
    &&  point_in_rectangle(_x, _y, _bbox.l, _bbox.t, _bbox.r, _bbox.b))
    {
        return true;
    }
    
    //Otherwise return nothing
    return false;
}