global.radiobuttonTest = 0;

with(bento_style_template("10px margin"))
{
    margin = 10;
}

box = bento_box_region(50, 50, room_width-50, room_height-50)
with(box)
{
    set_name("root");
    
    with(style)
    {
        color = c_red;
        alpha = 0.3;
        
        outline_color = c_white;
        outline_alpha = 0.5;
        outline_thickness = 2;
    }
    
    layout_set_flexbox("rows", "left", "top", "left", "top");
    /*
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
    
    with(bento_radiobutton(sCheckboxTest, global, "radiobuttonTest", "One", "10px margin"))
    {
        bento_label(self, "Radiobutton 0", 12);
    }
    
    with(bento_radiobutton(sCheckboxTest, global, "radiobuttonTest", "Two", "10px margin"))
    {
        bento_label(self, "Radiobutton 1", 12);
    }
    
    with(bento_radiobutton(sCheckboxTest, global, "radiobuttonTest", "Three", "10px margin"))
    {
        bento_label(self, "Radiobutton 2", 12);
    }
    */
    
    with(bento_box())
    {
        set_name("box");
        
        style.color = c_aqua;
        style.alpha = 1.0;
        
        var _decr_button = bento_button(sButtonTest, "10px margin");
        with(_decr_button)
        {
            set_name("decr");
            callback.mouse_released = function()
            {
                global.radiobuttonTest--;
            }
        }
        
        var _field = bento_textbox_string(global, "radiobuttonTest", 100, "10px margin");
        with(_field)
        {
            set_name("field");
            anchor_left(_decr_button, "right", 0, 0);
            anchor_top(_decr_button, "middle", 0, "-50%");
        }
        
        with(bento_button(sButtonTest, "10px margin"))
        {
            set_name("incr");
            anchor_left(_field, "right", 0, 0);
            anchor_top(_field, "middle", 0, "-50%");
            
            callback.mouse_released = function()
            {
                global.radiobuttonTest++;
            }
        }
    }
}

bento_layout_update(box);