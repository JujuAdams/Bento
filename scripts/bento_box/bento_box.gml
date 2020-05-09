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
    var _bbox_content = properties.bbox_content;
    
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
    
    //Draw the sprite (if needed)
    var _sprite_struct = style.sprite;
    if ((_sprite_struct.index != undefined) && (_sprite_struct.alpha > 0))
    {
        switch(_sprite_struct.behavior)
        {
            case "stretch":
                draw_sprite_stretched_ext(_sprite_struct.index, _sprite_struct.image,
                                          _bbox_padding.l, _bbox_padding.t,
                                          _bbox_padding.r - _bbox_padding.l, _bbox_padding.b - _bbox_padding.t,
                                          _sprite_struct.color, _sprite_struct.alpha);
            break;
            
            case "tile":
            case "tiled":
                var _sprite = _sprite_struct.index;
                var _image  = _sprite_struct.image;
                var _color  = _sprite_struct.color;
                var _alpha  = _sprite_struct.alpha;
                
                var _left = _bbox_padding.l;
                var _top  = _bbox_padding.t;
                var _w    = 1 + _bbox_padding.r - _bbox_padding.l;
                var _h    = 1 + _bbox_padding.b - _bbox_padding.t;
                
                var _sprite_w = sprite_get_width( _sprite);
                var _sprite_h = sprite_get_height(_sprite);
                
                var _tile_offset_x = _sprite_struct.tile_offset.x;
                var _tile_offset_y = _sprite_struct.tile_offset.y;
                
                if (_sprite_struct.tile_offset.worldspace)
                {
                    _tile_offset_x += _left;
                    _tile_offset_y += _top;
                }
                
                var _part_offset_x = _tile_offset_x mod _sprite_w;
                var _part_offset_y = _tile_offset_y mod _sprite_h;
                
                if (_tile_offset_x > 0) _part_offset_x -= _sprite_w;
                if (_tile_offset_y > 0) _part_offset_y -= _sprite_h;
                
                var _y1 = _part_offset_y;
                while(_y1 < _h)
                {
                    var _part_y = 0;
                    var _y2 = _y1 + _sprite_h;
                    
                    if (_y1 < 0)
                    {
                        _part_y = -_y1;
                        _y1 = 0;
                    }
                    
                    if (_y2 > _h) _y2 = _h;
                    
                    var _part_h = _y2 - _y1;
                    
                    var _x1 = _part_offset_x;
                    while(_x1 < _w)
                    {
                        var _part_x = 0;
                        var _x2 = _x1 + _sprite_w;
                    
                        if (_x1 < 0)
                        {
                            _part_x = -_x1;
                            _x1 = 0;
                        }
                        
                        if (_x2 > _w) _x2 = _w;
                        
                        draw_sprite_part_ext(_sprite, _image, _part_x, _part_y, _x2 - _x1, _part_h, _left + _x1, _top + _y1, 1.0, 1.0, _color, _alpha);
                        
                        _x1 = _x2;
                    }
                    
                    _y1 = _y2;
                }
            break;
            
            case "nineslice":
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
            break;
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