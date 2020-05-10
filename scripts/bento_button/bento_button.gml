/// @param sprite
/// @param [templateName]

function bento_button()
{
    var _sprite = argument[0];
    var _style  = (argument_count > 1)? argument[1] : undefined;
    
    //Create and extend the basic sprite element
    with(bento_sprite(_sprite, 0, _style))
    {
        //Make sure we set this checkbox to interactive
        style.interactive = true;
        
        //Give this element an internal mouse event function
        properties.internal_mouse_event = function(_event)
        {
            //Swap between images of our sprite based on what events are triggered
            switch(_event)
            {
                case "leave":    style.sprite.image = 0; break;
                case "enter":    style.sprite.image = 1; break;
                case "pressed":  style.sprite.image = 2; break;
                case "released": style.sprite.image = (properties.mouse.focus)? 1 : 0; break;
            }
        }
        
        return self;
    }
}