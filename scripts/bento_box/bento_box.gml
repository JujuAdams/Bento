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
        //Set some style variable specific to this kind of element
        with(style)
        {
            fill = {
                color : c_white,
                alpha : 0.0,
            };
            
            outline = {
                color : c_white,
                alpha : 0.0,
                thickness : 1.0,
            };
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
    
    //Draw the background fill using a single stretched sprite
    //This may seem a bit weird, but this is to ensure accuracy cross-platform
    var _fill = style.fill;
    if (_fill.alpha > 0.0)
    {
        draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                  _bbox_padding.l, _bbox_padding.t,
                                  1 + _bbox_padding.r - _bbox_padding.l,
                                  1 + _bbox_padding.b - _bbox_padding.t,
                                  _fill.color, _fill.alpha);
    }
    
    //Draw our outline using 4 stretched sprites
    var _outline = style.outline;
    if ((_outline.alpha > 0.0) && (_outline.thickness >= 1.0))
    {
        var _thickness = _outline.thickness;
        var _w = 1 + _bbox_padding.r - _bbox_padding.l;
        var _h = 1 + _bbox_padding.b - _bbox_padding.t;
        
        //Top
        draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                  _bbox_padding.l, _bbox_padding.t,
                                  _w, _thickness,
                                  _outline.color, _outline.alpha);
        
        //Left
        draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                  _bbox_padding.l, _bbox_padding.t + _thickness,
                                  _thickness, _h - 2*_thickness,
                                  _outline.color, _outline.alpha);
        
        //Bottom
        draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                  _bbox_padding.l, _bbox_padding.b + 1 - _thickness,
                                  _w, _thickness,
                                  _outline.color, _outline.alpha);
        
        //Right
        draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                  _bbox_padding.r + 1 - _thickness, _bbox_padding.t + _thickness,
                                  _thickness, _h - 2*_thickness,
                                  _outline.color, _outline.alpha);
    }
}