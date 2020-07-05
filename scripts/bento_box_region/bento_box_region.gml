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
        with(property)
        {
            with(bbox_outer)
            {
                //Directly set the position of the outer bounding box
                l = _left;
                t = _top;
                r = _right;
                b = _bottom;
            }
            
            source_width  = 1 + _right - _left;
            source_height = 1 + _bottom - _top;
        }
        
        //Update the other bounding boxes 
        update_from_bbox_outer();
        
        //Return this new element
        return self;
    }
}