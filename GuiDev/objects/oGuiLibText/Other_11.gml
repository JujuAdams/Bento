/// @desc Draw

if (hAlign == fa_left)
{
    var _x = guiLeft;
}
else if (hAlign = fa_right)
{
    var _x = guiRight;
}
else
{
    //Default horizontal alignment to center
    var _x = 0.5*(guiLeft + guiRight);
}

if (vAlign == fa_top)
{
    var _y = guiTop;
}
else if (vAlign = fa_bottom)
{
    var _y = guiBottom;
}
else
{
    //Default horizontal alignment to middle
    var _y = 0.5*(guiTop + guiBottom);
}

draw_set_font(font);
draw_set_halign(hAlign);
draw_set_valign(vAlign);
draw_text_ext_transformed_color(_x, _y, text, -1, guiWidth, image_xscale, image_yscale, image_angle, image_blend, image_blend, image_blend, image_blend, image_alpha);
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);