# Navigation

?> You should read up on Bento's [input modes](Topic-Input-Modes) before reading this article.

Navigation is the rules that govern how Input's [virtual cursor](Topic-Principles?id=virtual-cursor) moves between elements when using keyboard or gamepad input. When using these input modes, elements are highlighted using an invisible cursor that Bento keeps track of for you. The virtual cursor triggers [hover](Topic-Hover-Hold-Click-Focus?id=hover) state as a mouse pointer or touchpoint would. However, the virtual cursor cannot freely move around the screen and is limited to only hovering viable elements. Bento is set up so that any interface can be navigated with pointer input as well as navigation input.

There is one virtual cursor per layer. If you create a new layer then the virtual cursor for that layer and then destroy it, the underlying layer will remember which element was hovered. If there are any elements that can be hovered then Bento will always ensure that one of them is hovered by the virtual cursor. If the currently hovered element is destroyed or it otherwise becomes unhoverable then the virtual cursor will jump to the nearest element.

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

You may set the hover state for a certain element by calling `BentoHover()`. This function does not allow you to hover an inelligible element, however. You can also use `BentoHoverSoft()` to hover an element; this function will only set hover state if no other element is already hovered. This is helpful to encourage a particular option to be hovered when creating menus for the first time.

&nbsp;

## What can be hovered?

To reflect the complex needs of keyboard and gamepad input, Bento has lots of options for controlling how the virtual cursor moves. The common rule is that for any element to be hovered by the virtual cursor, the element must have the button type `BENTO_BUTTON_NAVIGATION` or `BENTO_BUTTON_ALWAYS` as set by `BentoSetButton()`. For the simplest use case, this is all that matters and navigation is straight-forward.

Normally, Bento will use a raycast (really a cone collision) to determine which element to hover. However, you can override the standard raycast by creating "links" between elements using `BentoNavigationLinkX()` and `BentoNavigationLinkY()`. You can further disable raycasting in particular cardinal directions by calling `BentoGetNavigationEnable()`. This latter function is helpful when creating sliders for settings menus.

Bento has special rules regarding scrolling lists. When an element is hovered by the virtual cursor, the scrolling list will scroll automatically to show the element. The virtual cursor will not leave an element due to user input until the hovered element is fully visible within the scrolling list. Furthermore, when Bento tries to hover an element inside a scrolling list from a position that it outside that scrolling list then Bento will prefentially choose element inside the list that are visible.

May also set up navigation wrapping with `BentoGetNavigationWrap()`. If Bento cannot find a suitable element in a particular direction then it will attempt to find another element on the other side of the screen. This feature works within the context of scrolling lists and Bento will try to wrap inside a scrolling list before allowing the cursor to escape the list and hover an outside element.

If an element has been [focused](Topic-Hover-Hold-Click-Focus?id=focus) and that element has no hoverable children then the virtual cursor cannot be moved away from the focused element. Additionally, elements that are enclosed within an unfocused parent cannot be hovered. Please see [this page](Topic-Hover-Hold-Click-Focus?id=enclosure) for more information on enclosing elements.

&nbsp;

## Drawing the virtual cursor

As previously mentioned, Bento's virtual cursor is invisible. However, it is very often a good idea to have some sort of visual indictation of what is hovered for the player's benefit. Bento offers a couple different ways to address this. The easiest way to indicate what is hovered is to write some conditional code in the element's Draw [user event](Topic-User-Events).

```gml
/// Draw user event

//Choose a yellow hue for the button when it's hovered
var _blend = `()? c_yellow : c_white;
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _blend, image_alpha);
```

This is the simplest way to communicate hover state to the player but it's often quite limiting. For example, if we wanted to draw a box around the button then we might run into draw order difficulties. To solve this, we can use the Draw Hover user event.

The Draw Hover user event is called by Bento after all other sibling elements have been drawn. Importantly, this event is only ever executed if the element is hovered (which means we don't need to check against `BentoPrimaryGetHover()` ourselves).

```gml
/// Draw Hover user event

//Draw a nine-sliced sprite around ourselves when we're hovered
BentoDrawSpriteAround(10, sHoverBorder, 0, c_yellow);
```

Using the Draw Hover user event is generally how I'd recommend drawing the virtual cursor but you can combine this with the Draw user event to create whatever effect you're looking for.

You can take care of drawing the virtual cursor yourself outside of Bento's standard draw loop. For example:

```gml
/// Draw GUI event

//Draw Bento elements
BentoSystemDraw();

//Draw the virtual cursor in navigation mode, provided that we're hovering an element
if (BentoUsingNavigation() && BentoLayerGetHoveringAny())
{
    with(BentoCursorGetBox())
    {
        var _padding = 10;
        draw_sprite_stretched_ext(sHoverBorder, 0, left - _padding, top - _padding, 1 + right - left + 2*_padding, 1 + bottom - top + 2*_padding, c_yellow, 1);
    }
}
```

You should take care to only draw the virtual cursor in this way if an element is hovered. `BentoCursorGetBox()` will still return coordinates even if no element is hovered which can lead to confusing situations for your players.