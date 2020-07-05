/// @param sprite
/// @param image
/// @param width
/// @param height
/// @param offsetX
/// @param offsetY

function bento_sprite_tile(_sprite, _image, _width, _height, _offset_x, _offset_y)
{
    with(new bento_class_element())
    {
        with(property)
        {
            //Set some style variables specific to this kind of element
            sprite = _sprite;
            image  = _image;
            
            tile_offset_x   = _offset_x;
            tile_offset_y   = _offset_y;
            tile_worldspace = false;
            
            //Set our dimensions based on the sprite we're using
            source_width  = _width;
            source_height = _height;
        }
        
        //Set draw method
        event.draw = bento_draw_sprite_tile;
        
        return self;
    }
}

function bento_draw_sprite_tile()
{
    with(property)
    {
        if ((sprite != undefined) && (alpha > 0))
        {
            var _left = bbox_base.l;
            var _top  = bbox_base.t;
            var _w    = 1 + bbox_base.r - bbox_base.l;
            var _h    = 1 + bbox_base.b - bbox_base.t;
            
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