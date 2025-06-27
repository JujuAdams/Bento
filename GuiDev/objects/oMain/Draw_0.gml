// Feather disable all

// Draws the entire Bento system. This should be in the same coordinate system as `BentoInputPointer()`.
// Not all Bento elements will necessarily be drawn. Those that do will call the Draw user event
// (`BENTO_USER_EVENT_DRAW`, 1). If `BentoSetDrawAfter()` has been called then the Draw After user
// event for that instance will be called too by `BentoSystemDraw()` (but won't by default).
BentoSystemDraw();

draw_set_font(fntDebug);

// Some debug text:
var _nodeName = "???";
switch(BentoGetMode())
{
    case BENTO_MODE_MOUSE:    _nodeName = "Mouse";    break;
    case BENTO_MODE_KEYBOARD: _nodeName = "Keyboard"; break;
    case BENTO_MODE_GAMEPAD:  _nodeName = "Gamepad";  break;
    case BENTO_MODE_TOUCH:    _nodeName = "Touch";    break;
}

draw_set_halign(fa_right);
draw_text(room_width-10, 10, $"Mode = {_nodeName}\n\n[1] = Mouse\n[2] = Keyboard\n[3] = Gamepad\n[4] = Touch");
draw_set_halign(fa_left);