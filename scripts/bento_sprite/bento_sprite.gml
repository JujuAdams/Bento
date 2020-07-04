/// @param sprite
/// @param image

function bento_sprite(_sprite, _image)
{
    with(new bento_class_element())
    {
        with(property)
        {
            //Set some style variables specific to this kind of element
            sprite = _sprite;
            image  = _image;
            
            //Set our dimensions based on the sprite we're using
            width  = sprite_get_width(sprite);
            height = sprite_get_height(sprite);
        }
        
        //Set draw method
        event.draw = bento_draw_sprite;
        
        return self;
    }
}

function bento_draw_sprite()
{
    with(property)
    {
        //Draw the sprite (if needed)
        if ((sprite != undefined) && (alpha > 0))
        {
            draw_sprite_stretched_ext(sprite, image,
                                      bbox_padding.l, bbox_padding.t,
                                      bbox_padding.r - bbox_padding.l, bbox_padding.b - bbox_padding.t,
                                      color, alpha);
        }
    }
}