box = bento_box_region(20, 20, room_width-20, room_height-20)
with(box)
{
    style.fill.alpha = 0.3;
    
    layout_flexbox();
    with(style.flexbox)
    {
        direction = "columns";
        line_halign = "left";
        line_valign = "top";
        content_halign = "around";
        content_valign = "between";
    }
    
    repeat(30)
    {
        with(bento_sprite(sTest, 0))
        {
            style.sprite.color = choose(c_red, c_lime, c_blue);
        }
    }
}

bento_layout_update(box);