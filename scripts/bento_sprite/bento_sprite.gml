/// @param sprite
/// @param image
/// @param [templateName]

function bento_sprite()
{
    var _sprite = argument[0];
    var _image  = argument[1];
    var _style  = (argument_count > 2)? argument[2] : undefined;
    
    with(new bento_element_class())
    {
        //Set some style variables specific to this kind of element
        with(style)
        {
            sprite = _sprite;
            image  = _image;
            color  = c_white;
            alpha  = 1.0;
        }
        
        //Apply our style template
        bento_style_template_apply(self, _style);
        
        //Set our dimensions based on the sprite we're using
        properties.width  = sprite_get_width( style.sprite);
        properties.height = sprite_get_height(style.sprite);
        
        //Set draw method
        callback.draw = bento_draw_sprite;
        
        return self;
    }
}

function bento_draw_sprite()
{
    var _bbox_padding = properties.bbox_padding;
    
    with(style)
    {
        //Draw the sprite (if needed)
        if ((sprite != undefined) && (alpha > 0))
        {
            draw_sprite_stretched_ext(sprite, image,
                                      _bbox_padding.l, _bbox_padding.t,
                                      _bbox_padding.r - _bbox_padding.l, _bbox_padding.b - _bbox_padding.t,
                                      color, alpha);
        }
    }
}