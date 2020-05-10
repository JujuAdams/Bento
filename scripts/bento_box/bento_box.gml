/// @param width
/// @param height
/// @param [templateName]

function bento_box()
{
    var _width  = argument[0];
    var _height = argument[1];
    var _style  = (argument_count > 2)? argument[2] : undefined;
    
    with(new bento_element_class(_style))
    {
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
    
    //Draw the background fill
    var _fill = style.fill;
    if (_fill.alpha > 0.0)
    {
        draw_sprite_stretched_ext(__spr_bento_pixel, 0,
                                  _bbox_padding.l, _bbox_padding.t,
                                  1 + _bbox_padding.r - _bbox_padding.l,
                                  1 + _bbox_padding.b - _bbox_padding.t,
                                  _fill.color, _fill.alpha);
    }
    
    //Draw our outline
    var _outline = style.outline;
    if (_outline.alpha > 0.0)
    {
        draw_set_colour(_outline.color);
        draw_set_alpha(_outline.alpha);
        
        draw_rectangle(_bbox_padding.l, _bbox_padding.t,
                       _bbox_padding.r, _bbox_padding.b, true);
    }
}