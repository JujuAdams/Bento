/// @param sprite

function bento_button(_sprite)
{
    //Create and extend the basic sprite element
    with(bento_sprite(_sprite, 0))
    {
        //Make sure we set this checkbox to interactive
        style.interactive = true;
        
        //Give this element an internal mouse event function
        properties.internal_mouse_event = function(_event)
        {
            //Swap between images of our sprite based on what events are triggered
            switch(_event)
            {
                case "leave":    style.image = 0; break;
                case "enter":    style.image = 1; break;
                case "pressed":  style.image = 2; break;
                case "released": style.image = (properties.mouse.focus)? 1 : 0; break;
            }
        }
        
        return self;
    }
}