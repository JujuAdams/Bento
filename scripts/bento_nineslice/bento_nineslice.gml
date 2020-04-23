/// @param sprite
/// @param image
/// @param width
/// @param height
/// @param [templateName]

function bento_nineslice()
{
    var _sprite = argument[0];
    var _image  = argument[1];
    var _width  = argument[2];
    var _height = argument[3];
    var _style  = (argument_count > 4)? argument[4] : undefined;
    
    with(new bento_element_class(_style))
    {
        //Set our dimensions based on the sprite we're using
        properties.width  = _width;
        properties.height = _height;
        
        //Set our sprite definition
        style.sprite.index     = _sprite;
        style.sprite.image     = _image;
        style.sprite.nineslice = true;
        
        if (_style == undefined)
        {
            style.sprite.nineslice_border = {
                l : sprite_get_width( _sprite)/3,
                t : sprite_get_height(_sprite)/3,
                r : sprite_get_width( _sprite)/3,
                b : sprite_get_height(_sprite)/3,
            };
        }
        
        //Set draw method
        callbacks.draw = bento_draw_box;
        
        return self;
    }
}