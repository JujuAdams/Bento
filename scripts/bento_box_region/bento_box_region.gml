/// @param left
/// @param top
/// @param right
/// @param bottom

function bento_box_region(_left, _top, _right, _bottom)
{
    var _width  = 1 + _right - _left;
    var _height = 1 + _bottom - _top;
    
    //Create a new element
    with(bento_box(_width, _height))
    {
        //Directly set the position of the margin
        properties.bbox_margin.l = _left;
        properties.bbox_margin.t = _top;
        properties.bbox_margin.r = _right;
        properties.bbox_margin.b = _bottom;
        
        //Update the other bounding boxes 
        update_bbox_from_margin();
        
        //Return this new element
        return self;
    }
}