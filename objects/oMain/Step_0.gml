// Feather disable all

if (keyboard_check_pressed(ord("1")))
{
    GuiNavSetMode(GUI_NAV_MOUSE);
}

if (keyboard_check_pressed(ord("2")))
{
    GuiNavSetMode(GUI_NAV_GAMEPAD);
}

if (keyboard_check_pressed(ord("3")))
{
    GuiNavSetMode(GUI_NAV_TOUCH);
}

GuiInputGamepad(keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left),
                keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up),
                keyboard_check(vk_space));

GuiInputMouseAndTouch(mouse_x, mouse_y, mouse_check_button(mb_left));

GuiInputButton(GUI_BUTTON_MOUSE_WHEEL_UP,   mouse_wheel_up());
GuiInputButton(GUI_BUTTON_MOUSE_WHEEL_DOWN, mouse_wheel_down());
GuiInputButton("escape", keyboard_check(vk_escape));

GuiStep();

if (keyboard_check_pressed(ord("D")))
{
    show_debug_message(GuiDebugStructure());
}