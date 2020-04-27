/// @param sprite
/// @param image
/// @param width
/// @param height
/// @param offsetX
/// @param offsetY
/// @param [templateName]

function bento_sprite()
{
    var _sprite   = argument[0];
    var _image    = argument[1];
    var _width    = argument[2];
    var _height   = argument[3];
    var _offset_x = argument[4];
    var _offset_y = argument[5];
    var _style    = (argument_count > 6)? argument[6] : undefined;
    
    with(new bento_element_class(_style))
    {
        //Set our dimensions based on the sprite we're using
        properties.width  = _width;
        properties.height = _height;
        
        //Set our sprite definition
        style.sprite.index         = _sprite;
        style.sprite.image         = _image;
        style.sprite.behavior      = "tile";
        style.sprite.tile_offset.x = _offset_x;
        style.sprite.tile_offset.y = _offset_y;
        
        //Set draw method
        callbacks.draw = bento_draw_box;
        
        return self;
    }
}