box = bento_box_region(50, 50, room_width-50, room_height-50)
with(box)
{
    style.fill.color = c_red;
    style.fill.alpha = 0.3;
    set_flexbox("columns", "left", "top", "left", "top");
    
    with(bento_button(sButtonTest))
    {
        set_name("A");
        style.margin = 10;
        
        callback.mouse_pressed = function()
        {
            show_debug_message(properties.long_name);
        }
    }
    
    with(bento_button(sButtonTest))
    {
        set_name("B");
        style.margin = 10;
        
        callback.mouse_event = function(_event)
        {
            show_debug_message(properties.long_name + ": " + _event);
        }
    }
    
    with(bento_checkbox(sCheckboxTest, global, "checkboxTest"))
    {
        set_name("C");
        style.margin = 10;
    }
    
    with(bento_radiobutton(sCheckboxTest, self, "checkbox", 1))
    {
        style.margin = 10;
    }
    
    with(bento_radiobutton(sCheckboxTest, self, "checkbox", 2))
    {
        style.margin = 10;
    }
    
    with(bento_radiobutton(sCheckboxTest, self, "checkbox", 3))
    {
        style.margin = 10;
    }
}

bento_layout_update(box);