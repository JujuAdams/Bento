# Technology - Input

?> This page covers some of the technology behind Bento. Because Bento is a framework that is intended to be used as the basis for later custom UI solutions, it's important that it's clear how things work and why. I encourage you to read Bento's source code as you read through this page.

&nbsp;

Input handling is a core feature of an user interface system. Bento supports mouse, keyboard, gamepad, and touchscreen input. Bento calls these different input methods "navigation modes". Bento doesn't inherently know what sort of input the player is using so you'll need to call `BentoSetMode()` to set a "navigation mode" according to what the player is currently using.

When Bento is initialized in your game, Bento will automatically select an navigation mode for you based on the operating system your game is running on:

- If the OS is Windows, MacOS, or Linux: Bento will use the value set by `BENTO_DESKTOP_DEFAULT_NAV_MODE` (ships as `BENTO_MODE_MOUSE`)
- If the OS is Android, iOS, or tvOS: Bento will use `BENTO_MODE_TOUCH`
- If the OS is Xbox, PlayStation, or Switch: Bento will use `BENTO_MODE_GAMEPAD`

Regardless of what navigation mode you're using, Bento will keep track of a virtual cursor position. Bento will also track a virtual primary "select button" which allows the player to click on buttons and generally interact with the user interface. Bento categories navigation modes into two distinct types, **pointer** and **directional**, so-named because of the way the cursor position is affected by the navigation mode. You'll need to use two different functions to tell Bento what inputs the user is making (`BentoInputPointer()` and `BentoInputDirectional()`).

## Pointer (mouse, touch)

Pointer input generalizes mouse and touch input. You can set the current cursor position and primary button state with `BentoInputPointer()` when using either 

```gml
if (BentoUsingPointer())
{
	// Using GUI-space coordinates
    var _x = device_mouse_x_to_gui(0);
    var _y = device_mouse_y_to_gui(0);
    BentoInputPointer(_x, _y, device_mouse_check_button(0, mb_left));
}
```

You need to be sensitive to the coordinate space that your user interface is designed for.

### Touch Differences

Whilst the mouse and touch navigation modes work basically the same, there are a couple important differences that you should be aware of.

- You can always scroll using a click-and-drag motion in touch mode (i.e. `GUI_SCROLL_ON_MOUSE_DRAG` is ignored when using touch input)
- `GuiCursorGetX()` and `GuiCursorGetY()` will both return 0 in touch mode when the primary button isn't held i.e. when the player isn't touching the screen

## Directional (keyboard, gamepad)

Directional input generalizes keyboard and gamepad input. Unlike pointer navigation modes, Bento's virtual cursor cannot move freely. Instead, the cursor will jump between elements that have been marked as buttons (which you can do with `BentoSetButton()`). You can push the cursor between buttons by using `BentoInputDirectional()`:

```gml
if (BentoUsingKeyboard())
{
    var _dX = keyboard_check(vk_right) - keyboard_check(vk_left);
    var _dY = keyboard_check(vk_down) - keyboard_check(vk_up);
    var _primary = keyboard_check(vk_space);

    BentoInputDirectional(_dX, _dY, _primary);
}
else if (BentoUsingGamepad() && gamepad_is_connected(_gamepad))
{
    var _gamepadDX = gamepad_axis_value(_gamepad, gp_axislh);
    var _gamepadDY = gamepad_axis_value(_gamepad, gp_axislv);

    //Apply a basic threshold to avoid uncontrolled jittery movement
    if (abs(_gamepadDX) > 0.2) _dX += sign(_gamepadDX);
    if (abs(_gamepadDY) > 0.2) _dY += sign(_gamepadDY);

    BentoInputDirectional(_dX, _dY, gamepad_button_check(0, gp_face1));
}
```

You need to be sensitive to the coordinate space that your user interface is designed for.

## Detecting Input

Bento allows you to detect input in the Step user event for instance elements or the `funcStep` callback for struct elements. There are a variety of [input getter functions](). These functions can be used in the Step, Draw, and Draw After user events (and struct element callbacks).

The most important and useful input getter function is undoubtedly `BentoPrimaryGetClick()`. This function will return if an element has been clicked by the player. This should be the function that you check to see if a button has been activated. You can also directly check the press/hold/release state of the primary button on an instance but you should **not** rely on these functions to determine whether the player has clicked a button.

## Hotkeys

In addition to the navigation modes, Bento also supports device agnostic hotkeys (e.g. `escape` to open/close a pause menu, `backspace` to drop an item).