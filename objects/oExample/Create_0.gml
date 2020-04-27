box = bento_box_region(50, 50, room_width-50, room_height-50)
with(box)
{
    style.fill.color = c_red;
    style.fill.alpha = 0.3;
    set_flexbox("rows", "between", "middle", "left", "between");
    
    repeat(5)
    {
        repeat(5) bento_sprite_nineslice(s9SliceTest, 0, 96, 96);
        layout_newline();
    }
}

bento_layout_update(box);