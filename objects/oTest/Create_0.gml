with(bento_style_template("big box"))
{
    fill.alpha = 1.0;
    padding = 10;
}

//with(bento_style_template("text"))
//{
//    padding = 10;
//}

document = bento_box_region(20, 20, room_width-20, room_height-20);
with(document)
{
    with(style)
    {
        fill.alpha = 0.2;
        margin = 30;
    }
    
    layout_flexbox();
    
    repeat(3) add(bento_box(100, choose(50, 100, 150), "big box"));
    layout_newline();
    repeat(20) with(add(bento_sprite(sTest, 0))) style.padding = 5;
    layout_newline();
    add(bento_box(100, 100, "big box"));
    
    /*
    set_grid([128, 128, 128, 128, 128], [128, 128, 128, 128, 128]);
    with(style)
    {
        grid.column_gap = 30;
        grid.row_gap = 30;
        grid.content_halign = "between";
        grid.content_valign = "even";
        grid.element_halign = "stretch";
        grid.element_valign = "stretch";
    }
    
    repeat(7) add(bento_sprite(sTest, -1));
    */
}