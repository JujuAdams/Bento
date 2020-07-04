/// @param width
/// @param height

function bento_box(_width, _height)
{
    with(new bento_class_element())
    {
        with(property)
        {
            //Set some style variables specific to this kind of element
            outline_color     = c_white;
            outline_alpha     = 0.0;
            outline_thickness = 1.0;
            
            width  = _width;
            height = _height;
        }
        
        //Set draw method
        event.draw = bento_draw_box;
        
        return self;
    }
}

function bento_draw_box()
{
    with(property)
    {
        //Background fill
        bento_draw_rectangle(bbox_padding.l, bbox_padding.t,
                             bbox_padding.r, bbox_padding.b,
                             color, alpha, 0);
        
        //Outline
        if (outline_thickness > 0.0)
        {
            bento_draw_rectangle(bbox_padding.l, bbox_padding.t,
                                 bbox_padding.r, bbox_padding.b,
                                 outline_color, outline_alpha,
                                 outline_thickness);
        }
    }
}