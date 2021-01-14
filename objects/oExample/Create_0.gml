box = bento_box_region(50, 50, room_width-50, room_height-50)
with(box)
{
    with(property)
    {
        clip = true;
        
        color = c_red;
        alpha = 0.3;
        
        outline_color = c_white;
        outline_alpha = 0.5;
        outline_thickness = 2;
        
        inner_space.clear(5);
    }
    
    var _group = bento_group_push();
    
    with(bento_button(sButtonTest))
    {
        property.outer_space.clear(5);
        align_x_to_target_x(bento_prev);
        align_t_to_target_t(bento_prev);
    }
    
    with(bento_button(sButtonTest))
    {
        property.outer_space.clear(5);
        align_x_to_target_x(bento_prev);
        align_t_to_target_b(bento_prev);
    }
    
    var _a = bento_button(sButtonTest);
    with(_a)
    {
        property.outer_space.clear(5);
        align_x_to_target_x(bento_prev);
        align_t_to_target_b(bento_prev);
    }
    
    with(bento_button(sButtonTest))
    {
        property.outer_space.clear(5);
        align_r_to_target_l(_a);
        align_t_to_target_t(_a);
    }
    
    with(bento_button(sButtonTest))
    {
        property.outer_space.clear(5);
        align_l_to_target_r(_a);
        align_t_to_target_t(_a);
    }
    
    with(bento_button(sButtonTest))
    {
        property.outer_space.clear(5);
        align_x_to_target_x(_a);
        align_t_to_target_b(_a);
    }
    
    with(bento_button(sButtonTest))
    {
        property.outer_space.clear(5);
        align_l_to_target_l(bento_prev);
        align_t_to_target_b(bento_prev);
        align_b_to_target_b(bento_prev, "50%");
    }
    
    bento_group_pop();
    
    with(bento_button(sButtonTest))
    {
        property.outer_space.clear(5);
        align_l_to_target_r(_group);
        align_y_to_target_y(_group);
    }
}