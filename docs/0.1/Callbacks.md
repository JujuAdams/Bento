# Callbacks

&nbsp;

?> If you're looking for BentoScript variables and GML functions that set up callbacks, check out [this page](Shared-Callbacks).

&nbsp;

## General

### Step

Called by proxy when `BentoStep()` is called. Step callbacks are executed by traversing the tree depth-first.

### Draw

Called by proxy when `BentoDraw()` is called. Draw callbacks are executed by traversing the tree depth-first.

### OnClose

Called when the UI element is finished constructing. For the avoidance of doubt:

```
build BentoRectangle {
	fillAlpha = 0.8
}  <--  OnClose callback executed here
```

```gml
BentoOpen(new BentoClassRectangle());
	BentoCurrent().Set("fillAlpha", 0.8);
BentoClose();  <--  OnClose callback executed here
```

### BuildIn

&nbsp;

## Button / Clicking

### ButtonClick

Called when a button is positively clicked by the player. This happens on button release. The `ButtonClick` callback can be triggered by either targetted or cast button clicks.

### ButtonStart

Called when a button is pressed whilst the UI element is focused. The button is considered "captured" for the purposes of the `Button` and `ButtonEnd` callbacks.

### Button

Called for every subsequent frame where the captured button (see above) is held.

### ButtonEnd

Called for when the captured button (see above) is released.

### ButtonCanCapture

Called when detecting if a signal from a button can be received by a UI element.

&nbsp;

## Pointer-Over / Highlight

### HoverStart

Called when highlighting a button (and it previously was in a non-highlighted state). This applies to mouse input and well as gamepad/keyboard input.

### Hover

Called for every subsequent frame that a button is highlighted.

### HoverEnd

Called when unhighlighting a button (and it previously was highlighted).

### CanHighlight

Called when detecting if a UI element can be highlighted.

&nbsp;

## Slider

### OnValueChange

Called when the handle for a slider is moved by the player. You could use this callback to set a variable elsewhere or to play a sound etc. 

### ValueUpdate

Called once when the slider is created, and then every frame. The intention is that this callback allows you to create a two-way binding for the slider. The function you set for this callback should return the value you want to set for the slider.

&nbsp;

## Layout

!> These two functions have niche use cases and may, at some point, be replaced.

### LayoutExecute

Called when deciding the layout of a UI element. You can (and should) use this callback to move child elements too.

### LayoutCheck

Called when deciding if the previously set layout (see above) is valid. The function you set for this callback should return `true` or `false` depending on whether the layout is still acceptable.