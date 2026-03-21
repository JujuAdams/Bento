// Feather disable all

/// @desc Draw

draw_sprite_ext(sprite_index, image_index, x + BENTO_EXAMPLE_SHADOW_OFFSET, y + BENTO_EXAMPLE_SHADOW_OFFSET, image_xscale, image_yscale, image_angle, c_black, BENTO_EXAMPLE_SHADOW_ALPHA);;

if (BentoPrimaryGetHold() && BentoGetClickable())
{
    x += 2;
    y += 2;
}

var _x = 0.5*(bbox_left + bbox_right);
var _y = 0.5*(bbox_top + bbox_bottom);

draw_sprite_ext(sBentoExButton, image_index, x, y, image_xscale, image_yscale, image_angle, BENTO_EXAMPLE_DARK_BLUE, image_alpha);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

draw_set_font(font);
draw_set_color(image_blend);

if (text != "")
{
    draw_set_halign(fa_center);
    draw_text(_x, bbox_top + 10, text);
    draw_set_halign(fa_left);
}

draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(_x, bbox_bottom - 10, BentoRefGet(reference, valueMin));
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_triangle(bbox_left+10, _y, bbox_left+25, _y-10, bbox_left+25, _y+10, false); 
draw_triangle(bbox_right-10, _y, bbox_right-25, _y-10, bbox_right-25, _y+10, false); 

draw_set_font(-1);
draw_set_color(c_white);

if (BentoPrimaryGetHold() && BentoGetClickable())
{
    x -= 2;
    y -= 2;
}