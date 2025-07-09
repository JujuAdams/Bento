// Feather disable all

BentoSandbox(0, 0, room_width, room_height);

draw_set_font(fntDebug);

// Some debug text:
var _modeName = "???";
switch(BentoGetMode())
{
    case BENTO_MODE_MOUSE:    _modeName = "mouse";    break;
    case BENTO_MODE_KEYBOARD: _modeName = "keyboard"; break;
    case BENTO_MODE_GAMEPAD:  _modeName = "gamepad";  break;
    case BENTO_MODE_TOUCH:    _modeName = "touch";    break;
}

draw_set_halign(fa_right);
draw_text(room_width-10, 10, $"Using {_modeName}");
draw_set_halign(fa_left);