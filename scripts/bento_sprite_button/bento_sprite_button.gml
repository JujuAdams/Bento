/// @param sprite
/// @param [templateName]

function bento_sprite_button()
{
    var _sprite = argument[0];
    var _style  = (argument_count > 1)? argument[1] : undefined;
    
    with(new bento_element_class(_style))
    {
        //Set our dimensions based on the sprite we're using
        properties.width  = sprite_get_width( _sprite);
        properties.height = sprite_get_height(_sprite);
        
        //Set our sprite definition
        style.sprite.index = _sprite;
        style.sprite.image = 0;
        
        //Set draw method
        callback.draw = bento_draw_box;
        properties.internal_mouse_event = function(_event)
        {
            switch(_event)
            {
                case "leave":    style.sprite.image = 0; break;
                case "enter":    style.sprite.image = 1; break;
                case "pressed":  style.sprite.image = 2; break;
                case "released": style.sprite.image = (properties.mouse.over)? 1 : 0; break;
            }
        }
        
        return self;
    }
}