box = bento_box_region(20, 20, room_width-20, room_height-20)
with(box)
{
    style.fill.alpha = 0.3;
    
    layout_flexbox();
    with(style.flexbox)
    {
        line_halign = "center";
        line_valign = "center";
        content_valign = "top";
    }
    
    
    bento_sprite(sTest, 0);
    with(bento_sprite(sTest, 0)) style.flexbox.grow = 1;
    with(bento_sprite(sTest, 0)) style.flexbox.grow = 2;
}

bento_layout_update(box);