/// @param left
/// @param top
/// @param right
/// @param bottom

function bento_box_region(_left, _top, _right, _bottom)
{
    //Create a new element
    with(new bento_element_class())
    {
        //Set our dimensions
        properties.width  = 1 + _right - _left;
        properties.height = 1 + _bottom - _top;
        properties.bbox_margin.l = _left;
        properties.bbox_margin.t = _top;
        properties.bbox_margin.r = _right;
        properties.bbox_margin.b = _bottom;
        
        //Set draw method
        callback.draw = bento_draw_box;
        
        //Return this new element
        return self;
    }
}