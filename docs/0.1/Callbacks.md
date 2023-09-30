# Callbacks

&nbsp;

?> If you're looking for BentoScript variables and GML functions that set up callbacks, check out [this page](Shared-Callbacks).

&nbsp;

## Callback Inheritance

Bento callbacks are automatically parented to the callback defined in the parent constructor. When implementing your own buttons, for example, you'll want to create your own constructor that inherits the native `BentoClassButton` constructor. To save you from the hassle of having to handle the implementation details of hooking your new button up to Bento's system, your new button constructor will automatically call all of the `BentoClassButton` callbacks with you needing to write any further code.

However, sometimes you might want to do something *in addition to* the existing template behaviour. This is where `BentoCallInherited()` comes in. If you call this function in your GML constructor then Bento will execute the full callback from the parent constructor (and if the parent's callback contains `BentoCallInherited()` then it'll call the next parent up, and so on). The BentScript equivalent is `CallInherited()` (or `Super()`). When extending and customising Bento, you'll want to invoke the parent's callback most of the time, apart from the Draw callback most likely.

&nbsp;

## General

### Step

<table>
    <tr>
		<td><b>BentoScript</b></td>
		<td><code>callbackStep</code></td>
    </tr>
    <tr>
		<td><b>GML constructor</b></td>
		<td><code>CallbackSetStep</code></td>
    </tr>
</table>

Called by proxy when `BentoStep()` is called. Step callbacks are executed by traversing the tree depth-first.

### Draw

<table>
    <tr>
		<td><b>BentoScript</b></td>
		<td><code>callbackStep</code></td>
    </tr>
    <tr>
		<td><b>GML constructor</b></td>
		<td><code>CallbackSetDraw</code></td>
    </tr>
</table>

Called by proxy when `BentoDraw()` is called. Draw callbacks are executed by traversing the tree depth-first.

### OnClose

<table>
    <tr>
		<td><b>BentoScript</b></td>
		<td><code>callbackOnClose</code></td>
    </tr>
    <tr>
		<td><b>GML constructor</b></td>
		<td><code>CallbackSetOnClose</code></td>
    </tr>
</table>

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

<table>
    <tr>
		<td><b>BentoScript</b></td>
		<td><code>callbackBuildIn</code></td>
    </tr>
    <tr>
		<td><b>GML constructor</b></td>
		<td><code>CallbackSetBuildIn</code></td>
    </tr>
</table>

Called by proxy when the UI element is generated, or when the `BuildIn()` method is executed for a UI element. Used to trigger an animation that visually introduces the UI element onto the screen.

&nbsp;

## Button / Clicking

!> Button callbacks will only works if you set either the `targetListen` or `castListen` variables so that Bento knows what button to listen for.

### ButtonClick

<!-- tabs:start -->

#### 

<table>
    <tr>
		<td><b>BentoScript</b></td>
		<td><code>callbackClick</code></td>
    </tr>
    <tr>
		<td><b>GML constructor</b></td>
		<td><code>CallbackSetButtonClick</code></td>
    </tr>
</table>

Called when a button is positively clicked by the player. This happens on button release. The `ButtonClick` callback can be triggered by either targetted or cast button clicks.

<!-- tabs:end -->

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