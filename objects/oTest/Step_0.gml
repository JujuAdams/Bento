if (keyboard_check_pressed(ord("1"))) useMouse = true; 
if (keyboard_check_pressed(ord("2"))) useMouse = false;

if (useMouse)
{
    BentoInputPointer(mouse_x, mouse_y);
    BentoInputButtonClick("action", mouse_check_button(mb_left));
    BentoInputButtonCast("quit", keyboard_check(vk_escape));
    BentoStep();
}
else
{
    //BentoInputDirection(gamepad_axis_value(0, gp_axislh), gamepad_axis_value(0, gp_axislv));
    //BentoInputButtonClick("action", gamepad_button_check(0, gp_face1));
    //BentoInputButtonClick("left", (gamepad_axis_value(0, gp_axislh) < -0.3));
    //BentoInputButtonClick("right", (gamepad_axis_value(0, gp_axislh) > 0.3));
    //BentoInputButtonCast("quit", gamepad_button_check(0, gp_start));
    
    BentoInputDirection(keyboard_check(vk_right) - keyboard_check(vk_left),
                        keyboard_check(vk_down) - keyboard_check(vk_up));
    BentoInputButtonClick("action", keyboard_check(vk_space));
    BentoInputButtonCast("quit", keyboard_check(vk_escape));
    BentoStep();
}