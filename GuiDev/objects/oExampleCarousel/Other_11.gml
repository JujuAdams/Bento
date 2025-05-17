/// @desc Draw

// Feather disable all

event_inherited();

var _x = 0.5*(bbox_left + bbox_right);
var _y = 0.5*(bbox_top + bbox_bottom);

draw_self();

if (GuiCursorGetOver())
{
    gpu_set_fog(true, c_white, 0, 0);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.3*image_alpha);
    gpu_set_fog(false, c_fuchsia, 0, 0);
}

if (title != "")
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text(_x, _y-5, title);
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
}

if (array_length(optionArray) > 0)
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    
    draw_text(_x, _y+5, optionArray[option]);
}

draw_triangle(bbox_left+5, _y+10, bbox_left+15, _y+5, bbox_left+15, _y+15, false); 
draw_triangle(bbox_right-5, _y+10, bbox_right-15, _y+5, bbox_right-15, _y+15, false); 