/// @desc Draw

// Feather disable all

event_inherited();

var _x = 0.5*(bbox_left + bbox_right);
var _y = 0.5*(bbox_top + bbox_bottom);

draw_self();

if (GuiCursorGetHover() || (GuiFocusGetTop() == self))
{
    gpu_set_fog(true, c_white, 0, 0);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.3*image_alpha);
    gpu_set_fog(false, c_fuchsia, 0, 0);
}

var _text = text;
if (GuiTextGetTargeted() && ((GuiTextGetOpenDuration() mod 30) < 15)) _text += "|";

draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(bbox_left + 10, _y, _text);
draw_set_halign(fa_left);
draw_set_valign(fa_top);