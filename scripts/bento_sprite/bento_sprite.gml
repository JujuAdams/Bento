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
            source_width  = sprite_get_width(sprite);
            source_height = sprite_get_height(sprite);
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
                                      bbox_base.l, bbox_base.t,
                                      bbox_base.r - bbox_base.l, bbox_base.b - bbox_base.t,
                                      color, alpha);
        }
    }
}