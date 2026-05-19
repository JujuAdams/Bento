/// @desc Draw

//Use the text alignment to figure out which side of the element to draw text on
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

//Set draw state
draw_set_font(font);
draw_set_halign(hAlign);
draw_set_valign(vAlign);

//Draw the text. We use the native colour/alpha for consistency with typical GameMaker behaviour.
//Additionally, we use the 
draw_text_ext_transformed_color(_x, _y, text, -1, bentoWidth, image_xscale, image_yscale, image_angle, image_blend, image_blend, image_blend, image_blend, image_alpha);

//Reset draw state
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);