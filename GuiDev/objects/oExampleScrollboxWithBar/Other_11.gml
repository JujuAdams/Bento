/// @desc Draw

if (GuiUsingDirectional())
{
    if (GuiFocusGetType())
    {
        var _fgColor = c_gray;
    }
    else if (GuiCursorGetHover())
    {
        var _fgColor = c_white;
    }
    else
    {
        var _fgColor = c_white;
    }
    
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _fgColor, image_alpha);
}
else
{
    draw_self();
}