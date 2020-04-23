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
        callbacks.draw = bento_draw_box;
        
        return self;
    }
}

function bento_draw_box()
{
    var _bbox_padding = properties.bbox_padding;
    var _bbox_content = properties.bbox_content;
    
    //Draw the background fill
    var _fill = style.fill;
    if (_fill.alpha > 0.0)
    {
        draw_set_colour(_fill.color);
        draw_set_alpha(_fill.alpha);
        
        draw_rectangle(_bbox_padding.l, _bbox_padding.t,
                       _bbox_padding.r, _bbox_padding.b, false);
    }
    
    //Draw the sprite (if needed)
    var _sprite_struct = style.sprite;
    if ((_sprite_struct.index != undefined) && (_sprite_struct.alpha > 0))
    {
        if (!_sprite_struct.nineslice)
        {
            draw_sprite_stretched_ext(_sprite_struct.index, _sprite_struct.image,
                                      _bbox_padding.l, _bbox_padding.t,
                                      _bbox_padding.r - _bbox_padding.l, _bbox_padding.b - _bbox_padding.t,
                                      _sprite_struct.color, _sprite_struct.alpha);
        }
        else
        {
            var _sprite = _sprite_struct.index;
            var _image  = _sprite_struct.image;
            var _color  = _sprite_struct.color;
            var _alpha  = _sprite_struct.alpha;
            
            var _l = _bbox_padding.l;
            var _t = _bbox_padding.t;
            var _r = _bbox_padding.r;
            var _b = _bbox_padding.b;
            var _w = _r - _l;
            var _h = _b - _t;
            
            var _nineslice_border = _sprite_struct.nineslice_border;
            var _border_l = _nineslice_border.l;
            var _border_t = _nineslice_border.t;
            var _border_r = _nineslice_border.r;
            var _border_b = _nineslice_border.b;
            
            var _center_w = sprite_get_width( _sprite) - (_border_l + _border_r);
            var _center_h = sprite_get_height(_sprite) - (_border_t + _border_b);
            var _border_i = _border_l + _center_w;
            var _border_j = _border_t + _center_h;
            
            var _xs = (_w - (_border_l + _border_r)) / _center_w;
            var _ys = (_h - (_border_t + _border_b)) / _center_h;
            
            //Corners
            draw_sprite_part_ext(_sprite, _image,            0,         0,    _border_l, _border_t,    _l            , _t            ,    1.0, 1.0,    _color, _alpha);
            draw_sprite_part_ext(_sprite, _image,    _border_i,         0,    _border_r, _border_t,    _r - _border_r, _t            ,    1.0, 1.0,    _color, _alpha);
            draw_sprite_part_ext(_sprite, _image,            0, _border_j,    _border_l, _border_b,    _l            , _b - _border_b,    1.0, 1.0,    _color, _alpha);
            draw_sprite_part_ext(_sprite, _image,    _border_i, _border_j,    _border_r, _border_b,    _r - _border_r, _b - _border_b,    1.0, 1.0,    _color, _alpha);
            
            //Sides                                                                                                                                    
            draw_sprite_part_ext(_sprite, _image,    _border_l,         0,    _center_w, _border_t,    _l + _border_l, _t            ,    _xs, 1.0,    _color, _alpha);
            draw_sprite_part_ext(_sprite, _image,            0, _border_t,    _border_l, _center_h,    _l            , _t + _border_t,    1.0, _ys,    _color, _alpha);
            draw_sprite_part_ext(_sprite, _image,    _border_l, _border_j,    _center_w, _border_b,    _l + _border_l, _b - _border_b,    _xs, 1.0,    _color, _alpha);
            draw_sprite_part_ext(_sprite, _image,    _border_i, _border_t,    _border_r, _center_h,    _r - _border_r, _t + _border_t,    1.0, _ys,    _color, _alpha);
            
            //Centre                                                                                                                                  
            draw_sprite_part_ext(_sprite, _image,    _border_l, _border_t,    _center_w, _center_h,    _l + _border_l, _t + _border_t,    _xs, _ys,    _color, _alpha);
        }
    }
    
    //Draw the surface
    var _surface_struct = style.surface;
    var _surface = _surface_struct.index;
    if ((_surface != undefined) && surface_exists(_surface))
    {
        draw_surface_stretched_ext(_surface,
                                   _bbox_padding.l, _bbox_padding.t,
                                   _bbox_padding.r - _bbox_padding.l, _bbox_padding.b - _bbox_padding.t,
                                   _surface_struct.color, _surface_struct.alpha);
    }
    
    //Draw the text
    var _text = style.text;
    if ((_text.alpha > 0.0) && (properties.text != ""))
    {
        draw_set_font(_text.font);
        draw_set_colour(_text.color);
        draw_set_alpha(_text.alpha);
        draw_set_halign(_text.halign);
        draw_set_valign(_text.valign);
        
        if (_text.halign == fa_center)
        {
            var _x = (_bbox_content.l + _bbox_content.r)/2;
        }
        else if (_text.halign == fa_right)
        {
            var _x = _bbox_content.r;
        }
        else
        {
            var _x = _bbox_content.l;
        }
        
        if (_text.halign == fa_middle)
        {
            var _y = (_bbox_content.t + _bbox_content.b)/2;
        }
        else if (_text.halign == fa_bottom)
        {
            var _y = _bbox_content.b;
        }
        else
        {
            var _y = _bbox_content.t;
        }
        
        draw_text(_x, _y, properties.text);
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