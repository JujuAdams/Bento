/// @desc Draw

// Feather disable all

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

draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_text(_left + 5, y - 2, title);

if (array_length(optionArray))
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    draw_text(x, y+10, optionArray[option]);
    draw_triangle(_left+5, y+10, _left+15, y+5, _left+15, y+15, false); 
    draw_triangle(_right-5, y+10, _right-15, y+5, _right-15, y+15, false); 
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (GuiNavGetOver())
{
    draw_set_alpha(0.5);
    draw_rectangle(_left, _top, _right, _bottom, false);
    draw_set_alpha(1);
}