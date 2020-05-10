with(bento_style_template("10px margin"))
{
    margin = 10;
}

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
    
    layout_set_flexbox("columns", "left", "top", "left", "top");
    
    bento_text("Hello world! :D", "10px margin");
    
    with(bento_button(sButtonTest, "10px margin"))
    {
        callback.mouse_pressed = function()
        {
            show_debug_message(properties.long_name);
        }
    }
    
    with(bento_button(sButtonTest, "10px margin"))
    {
        callback.mouse_event = function(_event)
        {
            show_debug_message(properties.long_name + ": " + _event);
        }
    }
    
    bento_checkbox(sCheckboxTest, global, "checkboxTest");
    bento_radiobutton(sCheckboxTest, self, "checkbox", 1, "10px margin");
    bento_radiobutton(sCheckboxTest, self, "checkbox", 2, "10px margin");
    bento_radiobutton(sCheckboxTest, self, "checkbox", 3, "10px margin");
}

bento_layout_update(box);