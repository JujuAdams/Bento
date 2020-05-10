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
        //Set our sprite definition
        style.sprite.index = _sprite;
        style.sprite.image = _image;
        
        //Apply our style template
        bento_style_template_apply(self, _style);
        
        //Set our dimensions based on the sprite we're using
        properties.width  = sprite_get_width( style.sprite.index);
        properties.height = sprite_get_height(style.sprite.index);
        
        //Set draw method
        callback.draw = bento_draw_sprite;
        
        return self;
    }
}

function bento_draw_sprite()
{
    //Draw the sprite (if needed)
    var _sprite_struct = style.sprite;
    if ((_sprite_struct.index != undefined) && (_sprite_struct.alpha > 0))
    {
        var _bbox_padding = properties.bbox_padding;
        draw_sprite_stretched_ext(_sprite_struct.index, _sprite_struct.image,
                                  _bbox_padding.l, _bbox_padding.t,
                                  _bbox_padding.r - _bbox_padding.l, _bbox_padding.b - _bbox_padding.t,
                                  _sprite_struct.color, _sprite_struct.alpha);
    }
}