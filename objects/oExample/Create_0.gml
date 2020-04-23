box = bento_box_region(20, 20, room_width-20, room_height-20)
with(box)
{
    style.fill.alpha = 0.3;
    
    layout_flexbox();
    
    repeat(30)
    {
        bento_sprite(sTest, 0);
    }
}

bento_layout_update(box);