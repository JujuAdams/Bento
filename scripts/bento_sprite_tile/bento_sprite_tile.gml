/// @param sprite
/// @param image
/// @param width
/// @param height
/// @param offsetX
/// @param offsetY
/// @param [templateName]

function bento_sprite_tile()
{
    var _sprite   = argument[0];
    var _image    = argument[1];
    var _width    = argument[2];
    var _height   = argument[3];
    var _offset_x = argument[4];
    var _offset_y = argument[5];
    var _style    = (argument_count > 6)? argument[6] : undefined;
    
    with(new bento_element_class())
    {
        //Set some style variables specific to this kind of element
        with(style)
        {
            sprite = _sprite;
            image  = _image;
            color  = c_white;
            alpha  = 1.0;
            
            tile_offset_x = _offset_x;
            tile_offset_y = _offset_y;
            tile_worldspace = false;
        }
        
        //Apply our style template
        bento_style_template_apply(self, _style);
        
        //Set our dimensions based on the sprite we're using
        properties.width  = _width;
        properties.height = _height;
        
        //Set draw method
        callback.draw = bento_draw_sprite_tile;
        
        return self;
    }
}

function bento_draw_sprite_tile()
{
    var _bbox_padding = properties.bbox_padding;
    
    with(style)
    {
        if ((sprite != undefined) && (alpha > 0))
        {
            var _left = _bbox_padding.l;
            var _top  = _bbox_padding.t;
            var _w    = 1 + _bbox_padding.r - _bbox_padding.l;
            var _h    = 1 + _bbox_padding.b - _bbox_padding.t;
            
            var _sprite_w = sprite_get_width( sprite);
            var _sprite_h = sprite_get_height(sprite);
            
            var _tile_offset_x = tile_offset_x;
            var _tile_offset_y = tile_offset_y;
            
            if (tile_worldspace)
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
                    
                    draw_sprite_part_ext(sprite, image, _part_x, _part_y, _x2 - _x1, _part_h, _left + _x1, _top + _y1, 1.0, 1.0, color, alpha);
                    
                    _x1 = _x2;
                }
                
                _y1 = _y2;
            }
        }
    }
}