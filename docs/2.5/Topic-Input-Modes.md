# Input Modes

&nbsp;

Bento supports four different **input modes**:

| Input Mode | Constant              | Pointer | Navigation | Prefer click-on-press |
|------------|-----------------------|---------|------------|-----------------------|
| Mouse      | `BENTO_MODE_MOUSE`    | Yes     | No         | No                    |
| Touch      | `BENTO_MODE_TOUCH`    | Yes     | No         | Yes                   |
| Keyboard   | `BENTO_MODE_KEYBOARD` | No      | Yes        | Yes                   |
| Gamepad    | `BENTO_MODE_GAMEPAD`  | No      | Yes        | Yes                   |

Bento will initialize using a suitable input mode for your game depending on what target platform you're using:

| Platform                                    | Initial Input Mode               |
|---------------------------------------------|----------------------------------|
| Windows<br>Mac<br>Linux                     | `BENTO_DESKTOP_DEFAULT_NAV_MODE` |
| Nintendo Switch<br>Sony PlayStation<br>Xbox | Gamepad                          |
| iOS<br>Android<br>tvOS                      | Touch                            |
| Other platforms                             | Gamepad                          |

`BENTO_DESKTOP_DEFAULT_NAV_MODE` is a config macro and can be found in `__BentoConfig`.

"Keyboard" input mode is intended for use in games that only use keyboard input and eschew mouse input entirely. This would largely be retro-styled games where menu navigation and gameplay use the arrow keys / WASD.

You may change input mode at any time by calling `BentoSetMode()` and you can return the current mode by calling `BentoGetMode()`. You may also call the various `BentoUsing*()` functions to return what input mode is being using in a semantically convenient way.

Input modes are split into two broader categories: "pointer" and "navigation". Pointer input modes - that's mouse and touch input - chiefly use a pointer to interact with a user interface. Navigation input modes - gamepad and keyboard - instead use a virtual cursor to navigate around an interface. Bento supports both and for basic operation you do not need to differentiate between pointer input and navigation input when writing code using Bento.

Bento also respects typical UX practices when it comes to clicking (or "activating" etc.) user interface elements. When using a mouse, it is usually the case that a button is only considered "clicked" when the mouse button is released. However, on a touchscreen and when using a gamepad or keyboard, it's usually the case that a button is "clicked" when pressed rather than released. As such, Bento will treat user interface elements as clicked in different ways depending on the input mode.

!> It is very important to detect players clicking buttons by calling explicitly `BentoPrimaryGetClick()`. If you check against any other function then your user interface is liable to work incorrectly.

?> Click-on-press will be disabled in a few different situations, including if a user interface element is inside a scrollable container.

&nbsp;

## Setting And Getting

The centre of Bento's input system is "primary input". What a primary input is depends on your input mode and possibly even custom bindings. Speaking broadly, primary input is a mouse click, a finger press on a touch screen, the `A` button on a gamepad, or the spacebar on a keyboard. A primary input is a player communicating with a physical action "I want to select this thing that is highlighted on the screen". Bento also supports additonal inputs, called hotkeys, but primary input is where most of the action is.

Bento uses an "input funnel" pattern to collect player input and then process it. Practically, this means you will need to call `BentoInputPointer()` or `BentoInputNavigation()` depending on the input mode. You will also want to call `BentoInputHotkey()` to collect input in addition to the primary input. You should call these functions before `BentoSystemStep()`, usually every step.

Here's an example for funnelling input into Bento:

```gml
if (BentoUsingPointer())
{
	//Presumes we're drawing the UI in a Draw GUI event
    BentoInputPointer(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), device_mouse_check_button(0, mb_left));
}
else
{
    if (BentoUsingKeyboard())
    {
        var _dX = keyboard_check(vk_right) - keyboard_check(vk_left);
        var _dY = keyboard_check(vk_down) - keyboard_check(vk_up);
        BentoInputNavigation(_dX, _dY, keyboard_check(vk_space));
    }
    else if (BentoUsingGamepad() && gamepad_is_connected(0))
    {
        var _dX = gamepad_axis_value(0, gp_axislh) + (gamepad_button_check(0, gp_padr) - gamepad_button_check(0, gp_padl));
        var _dY = gamepad_axis_value(0, gp_axislv) + (gamepad_button_check(0, gp_padd) - gamepad_button_check(0, gp_padu));
        BentoInputNavigation(_dX, _dY, gamepad_button_check(0, gp_face1));
    }
}

//Presumes we're drawing the UI in a Draw GUI event
BentoSystemStep(0, 0, display_get_gui_width(), display_get_gui_height());
```

?> If you're using the ["Input" library](https://codeberg.org/offalynne/Input) then you can simplify the code above. Please see [this article](Topic-Input-Library) for more information.

Bento will process input when you call `BentoSystemStep()`. You can then check the state of user interface elements by calling various functions. The most important is `BentoPrimaryGetClick()` which detects when the player has clicked on an element. You should call `BentoPrimaryGetClick()` in User Event 0 for elements that are objects instances, or in the `eventStep` method for elements that are structs.

!> It is very important to detect players clicking buttons by calling explicitly `BentoPrimaryGetClick()`. If you check against any other function then your user interface is liable to work incorrectly.

Bento has many getters that return input state, too many to cover here. Here are some that I find especially useful:

| Function                          | Usage                                                                             |
|-----------------------------------|-----------------------------------------------------------------------------------|
| `BentoPrimaryGetClick`            | Does it all                                                                       |
| `BentoCursorGetHover`             | Useful for changing user element appearance when a button is highlighted          |
| `BentoCursorGetBox`               | Helpful for drawing highlights around buttons when in navigation input modes      |
| `BentoCursorGetEnterByNavigation` | Good for triggering audio cues when entering an element                           |
| `BentoGetBlocksKeyboard`          | Prevents keyboard input from leaking to gameplay when the player is entering text |

&nbsp;


## Environments

Input modes are set by environment. Environments are an advanced feature and are [discussed elsewhere](Topic-Environments) but, briefly, if you'd like to have multiple players controlling different UIs at the same time then you should use one environment per player. This means that one player might be using a keyboard to control one environment whereas another player is using a gamepad to control the other environment. Bento supports this by allowing you to set input modes per environment.

!> If you're making a multiplayer game, make sure to keep the input mode up to date for whichever player is using that environment.
