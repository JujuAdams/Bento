/// @desc Draw

// Feather disable all

draw_set_color(GuiCursorGetOver()? c_gray : c_dkgray);
draw_rectangle(guiLeft, guiTop, guiRight, guiBottom, false);

draw_set_color((handleOver || handleGrabbed)? c_yellow : c_white);
draw_rectangle(guiLeft, handleTop, guiRight, handleBottom, false);

draw_set_color(c_white);