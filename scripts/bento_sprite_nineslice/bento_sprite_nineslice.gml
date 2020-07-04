/// @param sprite
/// @param image
/// @param width
/// @param height

function bento_sprite_nineslice(_sprite, _image, _width, _height)
{
    with(new bento_class_element())
    {
        //Set some style variables specific to this kind of element
        with(style)
        {
            sprite = _sprite;
            image  = _image;
            color  = c_white;
            alpha  = 1.0;
            
            nineslice = {
                l : sprite_get_width( _sprite)/3,
                t : sprite_get_height(_sprite)/3,
                r : sprite_get_width( _sprite)/3,
                b : sprite_get_height(_sprite)/3,
            };
        }
        
        //Set our dimensions based on the sprite we're using
        properties.width  = _width;
        properties.height = _height;
        
        //Set draw method
        event.draw = bento_draw_sprite_nineslice;
        
        return self;
    }
}

function bento_draw_sprite_nineslice()
{
    var _bbox_padding = properties.bbox_padding;
    
    with(style)
    {
        if ((sprite != undefined) && (alpha > 0))
        {
            var _l = _bbox_padding.l;
            var _t = _bbox_padding.t;
            var _r = _bbox_padding.r;
            var _b = _bbox_padding.b;
            var _w = _r - _l;
            var _h = _b - _t;
            
            var _border_l = nineslice.l;
            var _border_t = nineslice.t;
            var _border_r = nineslice.r;
            var _border_b = nineslice.b;
            
            var _center_w = sprite_get_width( sprite) - (_border_l + _border_r);
            var _center_h = sprite_get_height(sprite) - (_border_t + _border_b);
            var _border_i = _border_l + _center_w;
            var _border_j = _border_t + _center_h;
            
            var _xs = (_w - (_border_l + _border_r)) / _center_w;
            var _ys = (_h - (_border_t + _border_b)) / _center_h;
            
            //Corners
            draw_sprite_part_ext(sprite, image,            0,         0,    _border_l, _border_t,    _l            , _t            ,    1.0, 1.0,    color, alpha);
            draw_sprite_part_ext(sprite, image,    _border_i,         0,    _border_r, _border_t,    _r - _border_r, _t            ,    1.0, 1.0,    color, alpha);
            draw_sprite_part_ext(sprite, image,            0, _border_j,    _border_l, _border_b,    _l            , _b - _border_b,    1.0, 1.0,    color, alpha);
            draw_sprite_part_ext(sprite, image,    _border_i, _border_j,    _border_r, _border_b,    _r - _border_r, _b - _border_b,    1.0, 1.0,    color, alpha);
            
            //Sides                                                                                                                                  
            draw_sprite_part_ext(sprite, image,    _border_l,         0,    _center_w, _border_t,    _l + _border_l, _t            ,    _xs, 1.0,    color, alpha);
            draw_sprite_part_ext(sprite, image,            0, _border_t,    _border_l, _center_h,    _l            , _t + _border_t,    1.0, _ys,    color, alpha);
            draw_sprite_part_ext(sprite, image,    _border_l, _border_j,    _center_w, _border_b,    _l + _border_l, _b - _border_b,    _xs, 1.0,    color, alpha);
            draw_sprite_part_ext(sprite, image,    _border_i, _border_t,    _border_r, _center_h,    _r - _border_r, _t + _border_t,    1.0, _ys,    color, alpha);
            
            //Centre                                                                                                                                
            draw_sprite_part_ext(sprite, image,    _border_l, _border_t,    _center_w, _center_h,    _l + _border_l, _t + _border_t,    _xs, _ys,    color, alpha);
        }
    }
}