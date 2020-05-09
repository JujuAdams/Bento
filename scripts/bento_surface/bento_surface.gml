/// @param surface
/// @param [templateName]

function bento_surface()
{
    var _surface = argument[0];
    var _style   = (argument_count > 1)? argument[1] : undefined;
    
    with(new bento_element_class(_style))
    {
        //Set our dimensions based on the sprite we're using
        properties.width  = surface_get_width( _surface);
        properties.height = surface_get_height(_surface);
        
        //Set our sprite definition
        style.surface.index = _surface;
        
        //Set draw method
        callback.draw = bento_draw_box;
        
        return self;
    }
}