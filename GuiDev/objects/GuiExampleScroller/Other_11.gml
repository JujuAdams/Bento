/// @desc Draw

// Feather disable all

event_inherited();

var _x = GuiGetCenterX();
var _y = GuiGetCenterY();

draw_set_color(c_black);
draw_set_alpha(0.85);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
draw_set_color(c_white);
draw_set_alpha(1);

draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);

draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_text(bbox_left + 5, _y - 2, title);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(_x, _y+10, value);
draw_triangle(bbox_left+5, _y+10, bbox_left+15, _y+5, bbox_left+15, _y+15, false); 
draw_triangle(bbox_right-5, _y+10, bbox_right-15, _y+5, bbox_right-15, _y+15, false); 

draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (GuiNavGetOver())
{
    draw_set_alpha(0.5);
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
    draw_set_alpha(1);
}