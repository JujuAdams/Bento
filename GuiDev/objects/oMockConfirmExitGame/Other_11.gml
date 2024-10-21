/// @param Draw

// Feather disable all

GuiDrawClear(c_black, 0.5);

event_inherited();

draw_set_halign(fa_center);
draw_text(x, y - height/2 + 20, "Are you sure you want to exit the game?");
draw_set_halign(fa_top);