box = bento_box_region(20, 20, room_width-20, room_height-20)
with(box)
{
    style.fill.alpha = 0.3;
    set_flexbox("rows", "between", "middle", "left", "between");
    
    repeat(5)
    {
        repeat(5) bento_sprite(sTest, 0);
        layout_newline();
    }
}

bento_layout_update(box);