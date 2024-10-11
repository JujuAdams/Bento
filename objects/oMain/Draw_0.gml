// Feather disable all

GuiDraw();

draw_set_halign(fa_right);
draw_text(room_width-10, 10, $"Mode = {GuiNavGetMode()}\n\n[1] = Mouse\n[2] = Keyboard\n[3] = Touch");
draw_set_halign(fa_left);