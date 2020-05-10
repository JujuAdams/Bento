/// @param width
/// @param height
/// @param [templateName]

function bento_box()
{
    var _width  = argument[0];
    var _height = argument[1];
    var _style  = (argument_count > 2)? argument[2] : undefined;
    
    with(new bento_element_class())
    {
        //Set some style variables specific to this kind of element
        with(style)
        {
            color = c_white;
            alpha = 0.0;
            
            outline_color = c_white;
            outline_alpha = 0.0;
            outline_thickness = 1.0;
        }
        
        //Apply our style template
        bento_style_template_apply(self, _style);
        
        //Set our dimensions
        properties.width  = _width;
        properties.height = _height;
        
        //Set draw method
        callback.draw = bento_draw_box;
        
        return self;
    }
}

function bento_draw_box()
{
    var _bbox_padding = properties.bbox_padding;
    
    with(style)
    {
        //Draw the background fill using a single stretched sprite
        //This may seem a bit weird, but this is to ensure accuracy cross-platform
        if (alpha > 0.0)
        {
            draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                      _bbox_padding.l, _bbox_padding.t,
                                      1 + _bbox_padding.r - _bbox_padding.l,
                                      1 + _bbox_padding.b - _bbox_padding.t,
                                      color, alpha);
        }
        
        //Draw our outline using 4 stretched sprites
        if ((outline_alpha > 0.0) && (outline_thickness > 0.0))
        {
            var _w = 1 + _bbox_padding.r - _bbox_padding.l;
            var _h = 1 + _bbox_padding.b - _bbox_padding.t;
            
            //Top
            draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                      _bbox_padding.l, _bbox_padding.t,
                                      _w, outline_thickness,
                                      outline_color, outline_alpha);
            
            //Left
            draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                      _bbox_padding.l, _bbox_padding.t + outline_thickness,
                                      outline_thickness, _h - 2*outline_thickness,
                                      outline_color, outline_alpha);
            
            //Bottom
            draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                      _bbox_padding.l, _bbox_padding.b + 1 - outline_thickness,
                                      _w, outline_thickness,
                                      outline_color, outline_alpha);
            
            //Right
            draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                      _bbox_padding.r + 1 - outline_thickness, _bbox_padding.t + outline_thickness,
                                      outline_thickness, _h - 2*outline_thickness,
                                      outline_color, outline_alpha);
        }
    }
}