// Feather disable all

/// @desc Draw

//Always call this in events in objects that inherit from `oBentoAncestor`!
event_inherited();

var _x = 0.5*(bbox_left + bbox_right);
var _y = 0.5*(bbox_top + bbox_bottom);

draw_self();

if (BentoCursorGetHover())
{
    gpu_set_fog(true, c_white, 0, 0);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.3*image_alpha);
    gpu_set_fog(false, c_fuchsia, 0, 0);
}

if (text != "")
{
    draw_set_halign(fa_center);
    draw_text(_x, bbox_top + 5, text);
    draw_set_halign(fa_left);
}

if (array_length(optionArray) > 0)
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text(_x, bbox_bottom - 5, BentoRefIsAlive(reference)? string(BentoRefGet(reference, "")) : optionArray[0]);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

draw_triangle(bbox_left+5, _y, bbox_left+15, _y-5, bbox_left+15, _y+5, false); 
draw_triangle(bbox_right-5, _y, bbox_right-15, _y-5, bbox_right-15, _y+5, false); 