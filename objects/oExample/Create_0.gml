global.radiobuttonTest = 0;

box = bento_box_region(50, 50, room_width-50, room_height-50)
with(box)
{
    with(style)
    {
        color = c_red;
        alpha = 0.3;
        
        outline_color = c_white;
        outline_alpha = 0.5;
        outline_thickness = 2;
    }
    
    with(bento_box(properties.width, properties.height))
    {
        style.color = c_aqua;
        style.alpha = 1.0;
        
        with(bento_button(sButtonTest))
        {
            event.mouse_released = function()
            {
                global.radiobuttonTest--;
            }
        }
        
        with(bento_button(sButtonTest))
        {
            event.mouse_released = function()
            {
                global.radiobuttonTest++;
            }
        }
    }
}