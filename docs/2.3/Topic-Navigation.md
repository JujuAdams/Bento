# Navigation

?> You should read up on Bento's [input modes](Topic-Input-Modes) before reading this article.

Navigation is the rules that govern how Input's [virtual cursor](Topic-Principles?id=virtual-cursor) moves between elements when using keyboard or gamepad input. When using these input modes, elements are highlighted using an invisible cursor that Bento keeps track of for you. The virtual cursor triggers [hover](Topic-Hover-Hold-Click-Focus?id=hover) state as a mouse pointer or touchpoint would. However, the virtual cursor cannot freely move around the screen and is limited to only hovering viable elements. Bento is set up so that any interface can be navigated with pointer input as well as navigation input.

There is one virtual cursor per layer. If you create a new layer then the virtual cursor for that layer and then destroy it, the underlying layer will remember which element was hovered. If there are any elements that can be hovered then Bento will always ensure that one of them is hovered by the virtual cursor. If the currently hovered element is destroyed or it otherwise becomes unhoverable then the virtual cursor will jump to the nearest element. When navigating inside a scrolling list 

The cursor position is determined to be the centre of the currently hovered element. If no element is hovered because there are no viable elements then the x/y position of the cursor will remain at the last place an element was hovered. If no element has been hovered on a layer then the x/y position will be `0, 0`. You can return the position of the cursor with `BentoCursorGetX()` and `BentoCursorGetY()` as well as `BentoCursorGetBox()`.

The virtual cursor moves around your user interface when `BentoSystemStep()` is called. The direction that the cursor moves in determined by data set by `BentoInputNavigation()`. This function's first two arguments set the direction that the cursor moves in:

```gml
if (BentoUsingKeyboard())
{
    var _dX = keyboard_check(vk_right) - keyboard_check(vk_left);
    var _dY = keyboard_check(vk_down) - keyboard_check(vk_up);
    BentoInputNavigation(_dX, _dY, keyboard_check(vk_space));
}
else if (BentoUsingGamepad() && gamepad_is_connected(0))
{
    BentoInputNavigation(gamepad_axis_value(0, gp_axislh), gamepad_axis_value(0, gp_axislv), gamepad_button_check(0, gp_face1));
}

//Presumes we're drawing the UI in a Draw GUI event
BentoSystemStep(0, 0, display_get_gui_width(), display_get_gui_height());
```

In the above code, the cursor moves when the keyboard checks or gamepad thumbstick (for gamepad `0`) are moved. Using the direction that you've set, Bento will try to find the nearest elligible element in that direction. If an element is found then Bento will instantly move the virtual cursor to that element. This will cause the previous element to put into the ["leave"](Topic-Hover-Hold-Click-Focus?id=hover) state and the newly hovered element to be put into the "enter" state.

Bento will retrigger navigation if a direction is held for a long time. This will cause the virtual cursor to move between elements repeatedly if a direction is held. This is useful for navigating long lists of buttons. The rate that navigation will be retrigged can be changed by calling `BentoInputConfigureRetrigger()`. You can get the direction that the virtual cursor was pushed by calling `BentoCursorGetDX()` and `BentoCursorGetDY()`.

&nbsp;

## What can be hovered?

To reflect the complex needs of keyboard and gamepad input, Bento has lots of options for controlling how the virtual cursor moves. The common rule is that for any element to be hovered by the virtual cursor, the element must have the button type `BENTO_BUTTON_NAVIGATION` or `BENTO_BUTTON_ALWAYS` as set by `BentoSetButton()`.