/// @desc Draw

if (hAlign == fa_left)
{
    var _x = bentoLeft;
}
else if (hAlign = fa_right)
{
    var _x = bentoRight;
}
else
{
    //Default horizontal alignment to center
    var _x = 0.5*(bentoLeft + bentoRight);
}

if (vAlign == fa_top)
{
    var _y = bentoTop;
}
else if (vAlign = fa_bottom)
{
    var _y = bentoBottom;
}
else
{
    //Default horizontal alignment to middle
    var _y = 0.5*(bentoTop + bentoBottom);
}

draw_set_font(font);
draw_set_halign(hAlign);
draw_set_valign(vAlign);
var _text = (text != "")? text : emptyText;
draw_text_ext_transformed_color(_x, _y, _text, -1, bentoWidth, image_xscale, image_yscale, image_angle, image_blend, image_blend, image_blend, image_blend, image_alpha);
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);