// Feather disable all

/// @desc Draw

draw_sprite_ext(sprite_index, image_index, x + BENTO_EXAMPLE_SHADOW_OFFSET, y + BENTO_EXAMPLE_SHADOW_OFFSET, image_xscale, image_yscale, image_angle, c_black, BENTO_EXAMPLE_SHADOW_ALPHA);

var _centerX = 0.5*(bentoLeft + bentoRight);
var _centerY = 0.5*(bentoTop + bentoBottom);

if (BentoPrimaryGetHold() && BentoGetClickable())
{
    var _dX = 2;
    var _dY = 2;
}
else
{
    var _dX = 0;
    var _dY = 0;
}

draw_sprite_ext(sBentoExButton, image_index, x + _dX, y + _dY, image_xscale, image_yscale, image_angle, BENTO_EXAMPLE_DARK_BLUE, image_alpha);
draw_sprite_ext(sprite_index,   image_index, x + _dX, y + _dY, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

draw_set_font(font);
draw_set_color(image_blend);

if (text != "")
{
    draw_set_halign(fa_center);
    draw_text(_centerX + _dX, bentoTop + 10 + _dY, text);
    draw_set_halign(fa_left);
}

draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(_centerX + _dX, bentoBottom - 10 + _dY, BentoRefGet(reference, valueMin));
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_triangle(bentoLeft+10  + _dX, _centerY + _dY, bentoLeft+25  + _dX, _centerY-10 + _dY, bentoLeft+25  + _dX, _centerY+10 + _dY, false); 
draw_triangle(bentoRight-10 + _dX, _centerY + _dY, bentoRight-25 + _dX, _centerY-10 + _dY, bentoRight-25 + _dX, _centerY+10 + _dY, false); 

draw_set_font(-1);
draw_set_color(c_white);