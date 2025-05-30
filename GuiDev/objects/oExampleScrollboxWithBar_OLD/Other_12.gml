/// @desc Draw After

// Feather disable all

draw_set_color((overScrollbar || overHandle)? c_gray : c_dkgray);
draw_rectangle(scrollbarLeft, scrollbarTop, scrollbarRight, scrollbarBottom, false);

draw_set_color(overHandle? c_yellow : c_white);
draw_rectangle(scrollbarLeft, scrollbarHandleTop, scrollbarRight, scrollbarHandleBottom, false);

draw_set_color(c_white);