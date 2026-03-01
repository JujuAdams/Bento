// Feather disable all

// Draws the entire Bento system. This should be in the same coordinate system as `BentoInputPointer()`.
// Not all Bento elements will necessarily be drawn. Those that do will call the Draw user event
// (`BENTO_USER_EVENT_DRAW`, 1). If `BentoSetDrawAfter()` has been called then the Draw After user
// event for that instance will be called too by `BentoSystemDraw()` (but won't by default).
BentoSystemDraw(0, 0);

draw_set_font(fntDebug);

// Some debug text:
var _modeName = "???";
switch(BentoGetMode())
{
    case BENTO_MODE_MOUSE:    _modeName = "Mouse";    break;
    case BENTO_MODE_KEYBOARD: _modeName = "Keyboard"; break;
    case BENTO_MODE_GAMEPAD:  _modeName = "Gamepad";  break;
    case BENTO_MODE_TOUCH:    _modeName = "Touch";    break;
}

draw_set_halign(fa_right);
//draw_text(display_get_gui_width()-10, 10, $"Mode = {_modeName}\n\n[1] = Mouse\n[2] = Keyboard\n[3] = Gamepad\n[4] = Touch");
draw_set_halign(fa_left);