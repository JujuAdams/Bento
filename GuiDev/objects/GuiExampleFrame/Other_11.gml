/// @desc Draw

// Feather disable all

event_inherited();

draw_set_color(c_black);
draw_set_alpha(0.85);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
draw_set_color(c_white);
draw_set_alpha(1);

draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);