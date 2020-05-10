/// @param surface
/// @param [templateName]

function bento_surface()
{
    var _surface = argument[0];
    var _style   = (argument_count > 1)? argument[1] : undefined;
    
    with(new bento_element_class())
    {
        //Set some style variables specific to this kind of element
        surface = {
            index : _surface,
            color : c_white,
            alpha : 1.0,
        };
        
        //Apply our style template
        bento_style_template_apply(self, _style);
        
        //Set our dimensions based on the sprite we're using
        properties.width  = surface_get_width( _surface);
        properties.height = surface_get_height(_surface);
        
        //Set draw method
        callback.draw = bento_draw_surface;
        
        return self;
    }
}

function bento_draw_surface()
{
    //Get some data
    var _surface_struct = style.surface;
    var _surface = _surface_struct.index;
    
    //If our surface is valid and exists
    if ((_surface != undefined) && surface_exists(_surface))
    {
        //Draw it!
        var _bbox_padding = properties.bbox_padding;
        draw_surface_stretched_ext(_surface,
                                   _bbox_padding.l, _bbox_padding.t,
                                   _bbox_padding.r - _bbox_padding.l, _bbox_padding.b - _bbox_padding.t,
                                   _surface_struct.color, _surface_struct.alpha);
    }
}