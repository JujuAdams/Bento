global.radiobuttonTest = 0;

box = bento_box_region(50, 50, room_width-50, room_height-50)
with(box)
{
    with(property)
    {
        clip = false;
        
        color = c_red;
        alpha = 0.3;
        
        outline_color = c_white;
        outline_alpha = 0.5;
        outline_thickness = 2;
        
        padding.l = 10;
        padding.t = 10;
        padding.r = 10;
        padding.b = 10;
    }
    
    with(bento_button(sButtonTest))
    {
        align_x_to_target_x(other, 0);
        align_t_to_target_t(other, 0);
            
        event.mouse_released = function()
        {
            global.radiobuttonTest--;
        }
    }
    
    with(bento_button(sButtonTest))
    {
        align_x_to_target_x(bento_prev, 0);
        align_t_to_target_b(bento_prev, 0);
            
        event.mouse_released = function()
        {
            global.radiobuttonTest--;
        }
    }
}