# Your First Menu

&nbsp;

This page will go through the steps required to draw your very first menu. From this guide you'll learn the basic functions needed to set up Bento update and rendering as well as creating simple interactible elements.

&nbsp;

## 1. Import Bento into a new project

To keep things simple we'll be starting with Bento in a completely fresh GameMaker project.

You should download the Bento package (.yymps) from [the GitHub repo](https://github.com/JujuAdams/Bento/releases). You can import packages into GameMaker from the "Tools" menu and then the "Import Local Package" option. You'll need to add everything from the package.

?> You'll probably need to update Bento at some point. Please see the [update guide](Topic-Update-Guide) which will walk you through the process.

&nbsp;

## 2. Call `BentoSystemSandbox()`

We're going to use the convenience function `BentoSystemSandbox()` to get Bento set up quickly. We'll replace this function later but for now we want to move fast and get something on the screen quickly.

Please create a new object called `oUIController`. Place an instance of `oUIController` in the first room. We will use this a controller instance to update and draw Bento.

You should call `BentoSystemSandbox()` in a Draw GUI event of `oUIController`. You should use the size of the GUI for the function parameters like so:

```gml
/// Draw GUI event
BentoSystemSandbox(0, 0, display_get_gui_width(), display_get_gui_height());
```

&nbsp;

## 3. Build a button object

Please now make a new object in your project and call it `oButton`. Sets its parent to `oBentoAncestor` which is an object that is included with the library. You can find it in the asset browser in `Bento / Assets`. You should also set the sprite for `oButton` to `sBentoRectangleMask` so that the button has a collision mask.

Once you've created this object and set its parent, override the Create event and add `event_inherited()` at the top. This line of code ensures we set up the object as a Bento element. We can now add some further lines of code to set up the button:

```gml
/// Create event of oButton

//Set up this instance to work with Bento
event_inherited();

//Tell Bento that this instance is a button no matter what input mode we're using
BentoSetButton(BENTO_BUTTON_ALWAYS);

//This is the display text for the button
text = "Button";

//Set the size of the button to be the size of the string plus a little extra for padding
draw_set_font(-1);
BentoLayoutSetSize(string_width(text) + 20, string_height(text) + 20);
```

&nbsp;

## 4. Add code to Bento user events

In the `oButton`, override User Event 0. This user event is executed whenever a button is able to be hovered or clicked or otherwise interacted with. In this event, we'll check to see if the button has been clicked and, if so, show a pop-up message

```gml
/// User Event 0
/// @desc Step

//If the player clicks this button ...
if (BentoPrimaryGetClick())
{
	//... show a pop-up message
	show_message_async($"\"{text}\" pressed!");
}
```

Next, override User Event 1. This event is called when Bento wants to draw the element.

```gml
/// User Event 1
/// @desc Draw

//Draw the button background
draw_set_color(c_dkgray);
draw_rectangle(bentoLeft, bentoTop, bentoRight, bentoBottom, false);

//Draw the text for the button
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(-1);
draw_text(0.5*(bentoLeft + bentoRight), 0.5*(bentoTop + bentoBottom), text);

//Reset text draw state
draw_set_halign(fa_left);
draw_set_valign(fa_top);
```

&nbsp;

## 5. Create the button

In `oUIController`'s Create event, call `BentoCreate()`:

```gml
/// Create event of oUIController
BentoCreate(oButton, undefined, BentoLayerGetRoot());
```

&nbsp;

## 6. Run the game

You should see a button in the top-left corner of the screen. When you click the button you should see a pop-up message.

If you run into trouble then re-read the instructions so far paying attention to the following:
- Make sure `oUIController` is calling `BentoSystemSandbox()` in the Draw GUI event
- Ensure `oButton` inherits from `oBentoAncestor`
- Add a collision mask to `oButton` by setting its sprite to `sBentoRectangleMask`
- Check that the user events that you editted in `oButton` are correct (User Event 0 for click logic, User Event 1 for drawing)

&nbsp;

## 7. Improving the button

The button is very basic right now. Let's tweak it using some further Bento functions. The first thing we'll do is change the colour of the button when it is hovered. Open User Event 1 in `oButton` and enter the following code:

```gml
/// User Event 1
/// @desc Draw

//Draw the button background
draw_set_color(BentoGetHovered()? c_gray : c_dkgray);
draw_rectangle(bentoLeft, bentoTop, bentoRight, bentoBottom, false);

//Draw the button border when we're hovered
draw_set_color(c_white);
draw_rectangle(bentoLeft, bentoTop, bentoRight, bentoBottom, true);

//Set the colour of the text when hovered
draw_set_color(BentoGetHovered()? c_white : c_gray);

//Draw the text for the button
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(-1);
draw_text(0.5*(bentoLeft + bentoRight), 0.5*(bentoTop + bentoBottom), text);

//Reset text draw state, including colour
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
```

&nbsp;

## 8. Set up a list of buttons

Menus typically have more than one button. Return to `oUIController`'s Create event and paste the following code. We're going to take advantage of the fact that Bento elements are either object instances or structs and work with the native GameMaker `with()` instruction:

```gml
with(BentoLayerGetRoot())
{
	//Set the root element to lay out elements in a list in the y-axis
	//We also set the list to centre elements in both axes
    BentoLayoutList(BENTO_AXIS_Y, 0.5, 0.5);

    //Add some spacing between each button
    BentoLayoutSetGutter(0, 20);
    
    //Create three buttons!
    BentoCreate(oButton);
    BentoCreate(oButton);
    BentoCreate(oButton);
}
```

Run the game again and you'll see three buttons laid out in a vertical line in the centre of the game window. If you swap to using the keyboard or a gamepad then you will be able to navigate between buttons by using the thumbstick or arrow keys.

&nbsp;

## 9. Replace `BentoSystemSandbox()`

The function we used to get things up and running earlier is not something that should be used in production. For fear of setting a bad example, let's sort that out now.

First, open `oUIController`'s Draw GUI event, delete `BentoSystemSandbox()`, and replace it with `BentoSystemDraw()`:

```gml
/// Draw GUI event
BentoSystemDraw();
```

Secondly, add a new Step event to `oUIController`. In this event we'll update Bento's overall position and size as well as funnelling input into it:

```gml
///Step event

//Swap between input modes when pressing a number key
if (keyboard_check_pressed(ord("1"))) BentoSetMode(BENTO_MODE_MOUSE);
if (keyboard_check_pressed(ord("2"))) BentoSetMode(BENTO_MODE_KEYBOARD);
if (keyboard_check_pressed(ord("3"))) BentoSetMode(BENTO_MODE_GAMEPAD);
if (keyboard_check_pressed(ord("4"))) BentoSetMode(BENTO_MODE_TOUCH);

if (BentoUsingPointer())
{
    //Pointer input generalises both mouse and touch input
    BentoInputPointer(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), device_mouse_check_button(0, mb_left));
}
else
{
    if (BentoUsingKeyboard())
    {
        var _dX = keyboard_check(vk_right) - keyboard_check(vk_left);
        var _dY = keyboard_check(vk_down) - keyboard_check(vk_up);
        BentoInputDirectional(_dX, _dY, keyboard_check(vk_space));
    }
    else if (BentoUsingGamepad() && gamepad_is_connected(0))
    {
        //Only scan gamepad 0 for input. This is good enough for an example
        var _dX = gamepad_axis_value(0, gp_axislh) + (gamepad_button_check(0, gp_padr) - gamepad_button_check(0, gp_padl));
        var _dY = gamepad_axis_value(0, gp_axislv) + (gamepad_button_check(0, gp_padd) - gamepad_button_check(0, gp_padu));
        BentoInputDirectional(_dX, _dY, gamepad_button_check(0, gp_face1));
    }
}

//The main state update function. This ticks the entire system (but doesn't do any drawing).
//Step user events (BENTO_USER_EVENT_STEP etc.) are executed by this function where appropriate.
BentoSystemStep(0, 0, display_get_gui_width(), display_get_gui_height());
```

In a proper game project you will want to modify your input code to accommodate whatever input device the player is using. Regardless, run the game again to check that the new code is working properly. Don't forget to test out different input modes by pressing a number key.

?> If you're using the ["Input" library](https://codeberg.org/offalynne/Input) then you can simplify the code above. Please see [this article](Topic-Input-Library) for more information.

&nbsp;

## 10. Next steps

This guide has shown the bare basics of setting up a menu using Bento. It has included library import, basic system update and rendering, and building a button. You've learnt how to use the two most important User Events and how to automatically lay out element into a list.

Going forwards, you should experiment with making the buttons do different things such as starting the game or opening an options menu. You could also try adding a large title graphic as a new type of element added to the list. You could also try adding audio cues or particle effects when selecting a button (`BentoCursorGetEnterByNavigation()` is especially helpful for this).

Bento is a big library with lots to learn. From this basic starting point you will now be able to try out new things. Have fun!