# Input

&nbsp;

## …InputPointer

`BentoInputPointer(x, y, primaryAction)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`x`            |number  |x-coordinate of the pointer                         |
|`y`            |number  |y-coordinate of the pointer                         |
|`primaryAction`|boolean |Whether the primary action button is being held down|

Sets input values for pointer input (mouse and/or touch). The `primaryAction` argument should be set to the current held state of the primary "accept" or "confirm" button, conventionally the left mouse button (e.g. `device_mouse_check_button(0, mb_left)`). Pointer input generalises both mouse and touch input. The coordinate space for the x/y parameters should be the same as the coordinate space that `BentoSystemDraw()` is called in.

?> Pointer input is only valid when using the mouse or touch input modes. Pointer input will be ignored in other input modes.

#### **Examples**

```gml
// GUI-space coordinates
if (BentoUsingPointer())
{
	var _x = device_mouse_x_to_gui(0);
	var _y = device_mouse_y_to_gui(0);
	BentoInputPointer(_x, _y, device_mouse_check_button(0, mb_left));
}
```

```gml
// Room-space or view-space coordinates
if (BentoUsingPointer())
{
	/// View-space or room-space
	var _x = device_mouse_x(0);
	var _y = device_mouse_y(0);
	BentoInputPointer(_x, _y, device_mouse_check_button(0, mb_left));
}
```

<!-- tabs:end -->

&nbsp;

## …InputDirectional

`BentoInputDirectional(dX, dY, primaryAction)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`dX`           |number  |x-axis movement for the cursor                      |
|`dY`           |number  |y-axis movement for the cursor                      |
|`primaryAction`|boolean |Whether the primary action button is being held down|

Sets input values for directional input (gamepad and keyboard). The `primaryAction` argument should be set to the current held state of the primary "accept" or "confirm" button, conventionally the "A" button on a gamepad or the spacebar on a keyboard.

Sending in a directional value will push Bento's cursor in that direction. When holding a directional input, the Bento will automatically retrigger the directional input leading to auto-scrolling on menus. You can configure the auto-scroll behavior by calling `BentoInputConfigure()`.

?> Directional input is only valid when using the keyboard or gamepad input modes. Directional input will be ignored in other input modes.

#### **Examples**

```gml
if (BentoUsingKeyboard())
{
    var _dX = keyboard_check(vk_right) - keyboard_check(vk_left);
    var _dY = keyboard_check(vk_down) - keyboard_check(vk_up);
    var _primary = keyboard_check(vk_space);

    BentoInputDirectional(_dX, _dY, _primary);
}
```

```gml
if (BentoUsingGamepad() && gamepad_is_connected(_gamepad))
{
    var _gamepadDX = gamepad_axis_value(_gamepad, gp_axislh);
    var _gamepadDY = gamepad_axis_value(_gamepad, gp_axislv);

    //Apply a basic threshold to avoid uncontrolled jittery movement
    if (abs(_gamepadDX) > 0.2) _dX += sign(_gamepadDX);
    if (abs(_gamepadDY) > 0.2) _dY += sign(_gamepadDY);

    BentoInputDirectional(_dX, _dY, gamepad_button_check(0, gp_face1));
}
```

<!-- tabs:end -->

&nbsp;

## …InputHotkey

`BentoInputHotkey(name, value)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                              |
|-------|--------|-------------------------------------|
|`name` |string  |Name of the hotkey to target         |
|`value`|boolean |Whether the hotkey is being held down|

Sets input values for a named hotkey input. The name should be chosen to reflect the purpose of the input e.g. `"back"` or `"pause"` or `"scroll up"`. Button values can be read later uing the `BentoHotkeyGet*()` functions. The `value` parameter should be set to the current hold state of the hotkey e.g. `keyboard_check(vk_escape)`.

Hotkey input is available in all input modes. A "hotkey" is an abstract input that doesn't necessarily have to map to a physical input at all. Button input could be triggered by a tutorial, a cutscene, a touch gesture etc. ... or it could be a button. You can retrieve hotkey sate by calling the `InputHotkeyGet*()` functions.

#### **Examples**

```gml
//Pass a value into the "escape" hotkey
BentoInputHotkey("escape", keyboard_check(vk_escape));
```

```gml
//Pass values into the special mouse wheel up/down hotkeys
BentoInputHotkey(BENTO_HOTKEY_MOUSE_WHEEL_UP,   mouse_wheel_up());
BentoInputHotkey(BENTO_HOTKEY_MOUSE_WHEEL_DOWN, mouse_wheel_down());
```

<!-- tabs:end -->

&nbsp;

## …InputConsume

`BentoInputConsume()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name     |Datatype|Purpose        |
|---------|--------|---------------|
|`[layer]`|layer   |Layer to target|

"Consumes" all user input.

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …InputConfigure

`BentoInputConfigure(preDelay, delay, count, shortDelay)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name        |Datatype|Purpose                                                  |
|------------|--------|---------------------------------------------------------|
|`preDelay`  |number  |Steps to wait until retriggering directional input       |
|`delay`     |number  |Frames between retriggers                                |
|`count`     |integer |Number of retriggers before decreasing delay             |
|`shortDelay`|number  |Shorter delay to use after the above number of retriggers|

#### **Example**

```gml
GuiInputConfigure(10, 9, 4, 5);
```

<!-- tabs:end -->

&nbsp;

## …SetMode

`BentoSetMode(mode, [layer=current])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name     |Datatype|Purpose                                            |
|---------|--------|---------------------------------------------------|
|`mode`   |integer |Input mode to set, one of the `BENTO_MODE_*` macros|
|`[layer]`|layer   |Layer to target                                    |

Sets the current navigation mode. This should be one of the following constants:

- `BENTO_MODE_UNKNOWN`
- `BENTO_MODE_MOUSE`
- `BENTO_MODE_KEYBOARD`
- `BENTO_MODE_GAMEPAD`
- `BENTO_MODE_TOUCH`

Bento will consider mouse and touch input as "pointer" input and keyboard and gamepad input as "directional" input.

?> Setting the input mode to `BENTO_MODE_UNKNOWN` will disable all input.

#### **Example**

```gml
if (device_mouse_check_button_pressed(0, mb_any))
{
	//Swap to mouse control if the mouse button is pressed
	BentoSetMode(BENTO_MODE_MOUSE);
}
else if (keyboard_check_pressed(vk_space))
{
	//Swap to keyboard control if the spacebar is pressed
	BentoSetMode(BENTO_MODE_KEYBOARD);
}
```

<!-- tabs:end -->

&nbsp;

## …GetMode

`BentoGetMode([layer=current])`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, the input mode set for the given layer

|Name     |Datatype|Purpose        |
|---------|--------|---------------|
|`[layer]`|layer   |Layer to target|

Returns the current navigation mode, as set by `BentoSetMode()`. This will be one of the following constants:

- `BENTO_MODE_UNKNOWN`
- `BENTO_MODE_MOUSE`
- `BENTO_MODE_KEYBOARD`
- `BENTO_MODE_GAMEPAD`
- `BENTO_MODE_TOUCH`

#### **Example**

```gml
{

}
```

<!-- tabs:end -->

&nbsp;

## …UsingMouse

`BentoUsingMouse([layer=current])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the target layer is using mouse input

|Name     |Datatype|Purpose        |
|---------|--------|---------------|
|`[layer]`|layer   |Layer to target|

<!-- tabs:end -->

&nbsp;

## …UsingKeyboard

`BentoUsingKeyboard([layer=current])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the target layer is using keyboard input

|Name     |Datatype|Purpose        |
|---------|--------|---------------|
|`[layer]`|layer   |Layer to target|

<!-- tabs:end -->

&nbsp;

## …UsingGamepad

`BentoUsingGamepad([layer=current])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the target layer is using gamepad input

|Name     |Datatype|Purpose        |
|---------|--------|---------------|
|`[layer]`|layer   |Layer to target|

<!-- tabs:end -->

&nbsp;

## …UsingTouch

`BentoUsingTouch([layer=current])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the target layer is using touch input

|Name     |Datatype|Purpose        |
|---------|--------|---------------|
|`[layer]`|layer   |Layer to target|

<!-- tabs:end -->

&nbsp;

## …UsingPointer

`BentoUsingPointer([layer=current])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the target layer is using pointer (mouse or touch) input

|Name     |Datatype|Purpose        |
|---------|--------|---------------|
|`[layer]`|layer   |Layer to target|

<!-- tabs:end -->

&nbsp;

## …UsingDirectional

`BentoUsingDirectional([layer=current])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the target layer is using directional (keyboard or gamepad) input

|Name     |Datatype|Purpose        |
|---------|--------|---------------|
|`[layer]`|layer   |Layer to target|

<!-- tabs:end -->