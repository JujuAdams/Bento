/// @desc Draw

if (hAlign == fa_left)
{
    var _x = guiX;
}
else if (hAlign = fa_right)
{
    var _x = guiX + guiWidth;
}
else
{
    //Default horizontal alignment to center
    var _x = guiX + 0.5*guiWidth;
}

if (vAlign == fa_top)
{
    var _y = guiY;
}
else if (vAlign = fa_bottom)
{
    var _y = guiY + guiHeight;
}
else
{
    //Default horizontal alignment to middle
    var _y = guiY + 0.5*guiHeight;
}

draw_set_font(font);
draw_set_halign(hAlign);
draw_set_valign(vAlign);
draw_text_ext_transformed_color(_x, _y, text, -1, guiWidth, image_xscale, image_yscale, image_angle, image_blend, image_blend, image_blend, image_blend, image_alpha);
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);