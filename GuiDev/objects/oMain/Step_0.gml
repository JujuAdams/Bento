// Feather disable all

// Swap the navigation mode depending on what number row key has been pressed. In the main
// project, this is handled when the player hotswaps to another input device.
if (keyboard_check_pressed(ord("1"))) GuiSetMode(GUI_MODE_MOUSE);
if (keyboard_check_pressed(ord("2"))) GuiSetMode(GUI_MODE_KEYBOARD);
if (keyboard_check_pressed(ord("3"))) GuiSetMode(GUI_MODE_GAMEPAD);
if (keyboard_check_pressed(ord("4"))) GuiSetMode(GUI_MODE_TOUCH);

// "Gampead" input is, in reality, a generic directional input. Sending in a directional value
// will push the Gui cursor in that direction. When holding a directional input, the Gui system
// will automatically retrigger the directional input leading to auto-scrolling on menus. You can
// configure the auto-scroll behavior by calling `GuiInputConfigureRetrigger()`. The primary
// action parameter should be a continuous "held" value too. The Gui system handles the "pressed"
// and "released" state internally.
if (GuiUsingKeyboard())
{
    var _dX = keyboard_check(vk_right) - keyboard_check(vk_left);
    var _dY = keyboard_check(vk_down) - keyboard_check(vk_up);
    var _primary = keyboard_check(vk_space);
    GuiInputDirectional(_dX, _dY, _primary);
}
else if (GuiUsingGamepad() && gamepad_is_connected(0))
{
    var _gamepadDX = gamepad_axis_value(0, gp_axislh);
    var _gamepadDY = gamepad_axis_value(0, gp_axislv);
    var _dX = (abs(_gamepadDX) > 0.2)? sign(_gamepadDX) : 0;
    var _dY = (abs(_gamepadDY) > 0.2)? sign(_gamepadDY) : 0;
    GuiInputDirectional(_dX, _dY, gamepad_button_check(0, gp_face1));
}

// Pointer input generalises both mouse and touch input. As above, the primary action should be a
// continuous "held" value. The coordinate space for the x/y coordinates should be the same as the
// coordinate space that the Gui is drawn in. In this example, we're drawing the Gui in the
// standard Draw event which means we need to use room-space coordinates. If you're drawing in a
// Draw GUI event then you should use GUI-space coordinates.
if (GuiUsingPointer())
{
    GuiInputPointer(device_mouse_x(0), device_mouse_y(0), device_mouse_check_button(0, mb_left));
}

// No matter what navigation mode we're in, we can funnel "button" input into the system. "Button"\
// is an abstract input that doesn't necessarily have to map to a physical input at all. Button
// input could be triggered by a tutorial, a cutscene, a touch gesture etc. ... or it could be a
// button. Buttons have a "pressed", "held", and "released" state that is accessed via functions.
GuiInputHotkey(GUI_HOTKEY_MOUSE_WHEEL_UP,   mouse_wheel_up());
GuiInputHotkey(GUI_HOTKEY_MOUSE_WHEEL_DOWN, mouse_wheel_down());
GuiInputHotkey("escape", keyboard_check(vk_escape));

// The main state update function. This ticks the entire system (but doesn't do any drawing).
// Step user events (GUI_USER_EVENT_STEP, 0) are executed by this function where appropriate.
GuiSystemStep(room_width, room_height);