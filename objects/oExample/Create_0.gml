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
        
        inner_space.l = 10;
        inner_space.t = 10;
        inner_space.r = 10;
        inner_space.b = 10;
    }
    
    with(bento_button(sButtonTest))
    {
        align_x_to_target_x(bento_prev);
        align_t_to_target_t(bento_prev);
    }
    
    with(bento_button(sButtonTest))
    {
        align_x_to_target_x(bento_prev);
        align_t_to_target_b(bento_prev);
    }
    
    with(bento_button(sButtonTest))
    {
        align_l_to_target_r(bento_prev);
        align_t_to_target_b(bento_prev);
    }
    
    with(bento_button(sButtonTest))
    {
        align_r_to_target_l(bento_prev);
        align_t_to_target_b(bento_prev);
    }
    
    with(bento_button(sButtonTest))
    {
        align_l_to_target_l(bento_prev);
        align_r_to_target_l(bento_prev, "50%");
        align_t_to_target_b(bento_prev);
        align_b_to_target_b(bento_prev, "50%");
    }
}