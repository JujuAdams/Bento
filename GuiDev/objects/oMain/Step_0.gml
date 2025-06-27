// Feather disable all

// Swap the input mode depending on what number row key has been pressed. In the main
// project, this is handled when the player hotswaps to another input device.
if (keyboard_check_pressed(ord("1"))) BentoSetMode(BENTO_MODE_MOUSE);
if (keyboard_check_pressed(ord("2"))) BentoSetMode(BENTO_MODE_KEYBOARD);
if (keyboard_check_pressed(ord("3"))) BentoSetMode(BENTO_MODE_GAMEPAD);
if (keyboard_check_pressed(ord("4"))) BentoSetMode(BENTO_MODE_TOUCH);

// "Gampead" input is, in reality, a generic directional input. Sending in a directional value
// will push the Bento cursor in that direction. When holding a directional input, the Bento system
// will automatically retrigger the directional input leading to auto-scrolling on menus. You can
// configure the auto-scroll behavior by calling `BentoInputConfigureRetrigger()`. The primary
// action parameter should be a continuous "held" value too. The Bento system handles the "pressed"
// and "released" state internally.
if (BentoUsingKeyboard())
{
    var _dX = keyboard_check(vk_right) - keyboard_check(vk_left);
    var _dY = keyboard_check(vk_down) - keyboard_check(vk_up);
    var _primary = keyboard_check(vk_space);
    BentoInputDirectional(_dX, _dY, _primary);
}
else if (BentoUsingGamepad() && gamepad_is_connected(0))
{
    var _gamepadDX = gamepad_axis_value(0, gp_axislh);
    var _gamepadDY = gamepad_axis_value(0, gp_axislv);
    var _dX = (abs(_gamepadDX) > 0.2)? sign(_gamepadDX) : 0;
    var _dY = (abs(_gamepadDY) > 0.2)? sign(_gamepadDY) : 0;
    BentoInputDirectional(_dX, _dY, gamepad_button_check(0, gp_face1));
}

// Pointer input generalises both mouse and touch input. As above, the primary action should be a
// continuous "held" value. The coordinate space for the x/y coordinates should be the same as the
// coordinate space that the Bento is drawn in. In this example, we're drawing the Bento in the
// standard Draw event which means we need to use room-space coordinates. If you're drawing in a
// Draw Bento event then you should use GUI-space coordinates.
if (BentoUsingPointer())
{
    BentoInputPointer(device_mouse_x(0), device_mouse_y(0), device_mouse_check_button(0, mb_left));
}

// No matter what input mode we're in, we can funnel "button" input into the system. "Button"\
// is an abstract input that doesn't necessarily have to map to a physical input at all. Button
// input could be triggered by a tutorial, a cutscene, a touch gesture etc. ... or it could be a
// button. Buttons have a "pressed", "held", and "released" state that is accessed via functions.
BentoInputHotkey(BENTO_HOTKEY_MOUSE_WHEEL_UP,   mouse_wheel_up());
BentoInputHotkey(BENTO_HOTKEY_MOUSE_WHEEL_DOWN, mouse_wheel_down());
BentoInputHotkey("escape", keyboard_check(vk_escape));

// The main state update function. This ticks the entire system (but doesn't do any drawing).
// Step user events (BENTO_USER_EVENT_STEP, 0) are executed by this function where appropriate.
BentoSystemStep(room_width, room_height);

window_set_cursor(BentoGetBlocksMouse()? cr_drag : cr_default);