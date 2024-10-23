/// @desc Draw

// Feather disable all

GuiDrawClear();

event_inherited();

var _left   = x - width/2;
var _top    = y - height/2;
var _right  = x + width/2;
var _bottom = y + height/2;

draw_set_color(c_black);
draw_set_alpha(0.85);
draw_rectangle(_left, _top, _right, _bottom, false);
draw_set_color(c_white);
draw_set_alpha(1);

draw_rectangle(_left, _top, _right, _bottom, true);