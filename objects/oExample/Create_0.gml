global.radiobuttonTest = 0;

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
    
    bento_text("Hello world! :D", "10px margin");
    
    with(bento_checkbox(sCheckboxTest, global, "checkboxTest", "10px margin"))
    {
        bento_label(self, "Checkbox", 12);
    }
    
    bento_text("Hello world! :D", "10px margin");
    
    with(bento_radiobutton(sCheckboxTest, global, "radiobuttonTest", 0, "10px margin"))
    {
        bento_label(self, "Radiobutton 0", 12);
    }
    
    with(bento_radiobutton(sCheckboxTest, global, "radiobuttonTest", 1, "10px margin"))
    {
        bento_label(self, "Radiobutton 1", 12);
    }
    
    with(bento_radiobutton(sCheckboxTest, global, "radiobuttonTest", 2, "10px margin"))
    {
        bento_label(self, "Radiobutton 2", 12);
    }
}

bento_layout_update(box);