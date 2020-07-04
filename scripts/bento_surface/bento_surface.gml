/// @param surface

function bento_surface(_surface)
{
    with(new bento_class_element())
    {
        with(property)
        {
            //Set some style variables specific to this kind of element
            surface = _surface;
            
            //Set our dimensions based on the sprite we're using
            width  = surface_get_width(surface);
            height = surface_get_height(surface);
        }
        
        //Set draw method
        event.draw = bento_draw_surface;
        
        return self;
    }
}

function bento_draw_surface()
{
    with(property)
    {
        //If our surface is valid and exists
        if ((surface != undefined) && surface_exists(surface))
        {
            //Draw it!
            draw_surface_stretched_ext(surface,
                                       bbox_padding.l, bbox_padding.t,
                                       bbox_padding.r - bbox_padding.l, bbox_padding.b - bbox_padding.t,
                                       color, alpha);
        }
    }
}