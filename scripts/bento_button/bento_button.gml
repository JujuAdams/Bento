/// @param sprite

function bento_button(_sprite)
{
    //Create and extend the basic sprite element
    with(bento_sprite(_sprite, 0))
    {
        with(property)
        {
            //Make sure we set this element to interactive
            interactive = true;
            
            //Give this element an internal mouse event function
            fixed_mouse_event = function(_event)
            {
                with(property)
                {
                    //Swap between images of our sprite based on what events are triggered
                    switch(_event)
                    {
                        case "leave":    image = 0; break;
                        case "enter":    image = 1; break;
                        case "pressed":  image = 2; break;
                        case "released": image = (mouse.focus)? 1 : 0; break;
                    }
                }
            }
        }
        
        return self;
    }
}