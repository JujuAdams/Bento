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
            source_width  = surface_get_width(surface);
            source_height = surface_get_height(surface);
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
                                       bbox_base.l, bbox_base.t,
                                       bbox_base.r - bbox_base.l, bbox_base.b - bbox_base.t,
                                       color, alpha);
        }
    }
}