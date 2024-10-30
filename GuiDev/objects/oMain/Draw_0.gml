// Feather disable all

// Draws the entire Gui system. This should be in the same coordinate system as `GuiInputPointer()`.
// Not all Gui instances will necessarily be drawn. Those that do will call the Draw user event
// (`GUI_USER_EVENT_DRAW`, 1). If `GuiSetEnableDrawEnd()` has been called then the Draw End user
// event for that instance will be called too by `GuiDraw()` (but won't by default).
GuiDraw();

// Some debug text:
var _nodeName = "???";
switch(GuiNavGetMode())
{
    case GUI_NAV_MOUSE:   _nodeName = "Mouse";    break;
    case GUI_NAV_GAMEPAD: _nodeName = "Keyboard"; break;
    case GUI_NAV_TOUCH:   _nodeName = "Touch";    break;
}

draw_set_halign(fa_right);
draw_text(room_width-10, 10, $"Mode = {_nodeName}\n\n[1] = Mouse\n[2] = Keyboard\n[3] = Touch");
draw_set_halign(fa_left);