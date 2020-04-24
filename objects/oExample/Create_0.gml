box = bento_box_region(20, 20, room_width-20, room_height-20)
with(box)
{
    style.fill.alpha = 0.3;
    
    //layout_flexbox();
    //with(style.flexbox)
    //{
    //    direction = "columns";
    //    line_halign = "left";
    //    line_valign = "top";
    //    content_halign = "left";
    //    content_valign = "top";
    //}
    
    layout_grid([64, 64, 64, 64, 64, 64], [64, 64, 64, 64, 64, 64]);
    with(style.grid)
    {
        direction = "rows";
        line_halign = "left";
        line_valign = "top";
        content_halign = "even";
        content_valign = "top";
    }
    
    var _i = 50;
    repeat(25)
    {
        with(bento_sprite(sTest, 0))
        {
            style.sprite.color = make_color_rgb(_i, 0, 0);
            _i += 8;
        }
    }
}

bento_layout_update(box);