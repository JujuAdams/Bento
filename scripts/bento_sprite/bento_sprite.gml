/// @param sprite
/// @param image
/// @param [templateName]

function bento_sprite()
{
    var _sprite = argument[0];
    var _image  = argument[1];
    var _style  = (argument_count > 2)? argument[2] : undefined;
    
    with(new bento_element_class(_style))
    {
        //Set our dimensions based on the sprite we're using
        properties.width  = sprite_get_width( _sprite);
        properties.height = sprite_get_height(_sprite);
        
        //Set our sprite definition
        style.sprite.index = _sprite;
        style.sprite.image = _image;
        
        //Set draw method
        callbacks.draw = bento_draw_box;
        
        return self;
    }
}