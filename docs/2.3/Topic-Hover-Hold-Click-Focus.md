# Hover vs. Hold vs. Click vs. Focus

&nbsp;

Every user interface uses different terminology for element state. Bento has three main states that a button can be in: hovered, held, and focused. You may be familiar with these terms from other frameworks where their meaning and usage is different to Bento. Ahead of time, I will apologise for any confusion.

&nbsp;

## Hover

Bento's "hover" state is called "mouse over" or "highlight" in other UI frameworks. More technically, "hover" is a state that indicates an element will be the recipient of the primary input when activated (clicking a mouse button, pressing the spacebar, press the A button on a gamepad).

The hover state applies to pointer (mouse, touch) [input modes](Topic-Input-Modes) as well as navigation (keyboard, gamepad) input modes. When using a pointer input mode, an element will be hovered if it is the top-most element underneath the pointer.

When using a navigation input mode, Bento will track which element is hovered for you [using an internal cursor](Topic-Principles?id=virtual-cursor) without there being an explicit pointer coordinate. Bento will ensure that an element will always be hovered if there is a hoverable element available. This means that destroying the currently hovered element will cause the internal cursor to avoid another element, typically the next nearest element to where the cursor was previously. When using a navigation input mode, it is often helpful to be able to visualise where the internal cursor is. You may use the `BentoCursorGetBox()` function to return the bounding box of the element that the internal cursor is currently hovering.

Bento stores hover state per element. An element can have one of four values for its hover state. The table below explains when each state occurs.

|Name      |Hovered on the previous frame|Hovered on the current frame|Getter function                                                           |
|----------|-----------------------------|----------------------------|--------------------------------------------------------------------------|
|"no hover"|❌                          |❌                          |`not BentoCursorGetHover()`                                               |
|"enter"   |❌                          |✅                          |`BentoCursorGetEnterByNavigation()`<br>or `BentoCursorGetEnterByGeneral()`|
|"hover"   |✅                          |✅                          |`BentoCursorGetHover()`                                                   |
|"leave"   |✅                          |❌                          |`BentoCursorGetLeave()`                                                   |

You'll note detecting the "enter" state has two getters. The first getter, `BentoCursorGetEnterByNavigation()` is the function you'll usually want to use. This function will only return `true` when the player has hovered an element by making an input. This is very helpful when playing audio cues as the player navigates between elements. The second function, `BentoCursorGetEnterByGeneral()`, still has its uses but is rarer to see in practice.

Only one element may be hovered per layer. If a layer is backgrounded, the hovered element (if there is one) will be transitioned first to the "leave" state and then to the "no hover" state. When that layer is foregrounded, the element that was previously hovered will become hovered once again (via the "enter" state). An element on a backgrounded layer cannot be hovered in any situation.

Mindful of the above limits, an element is hovered in the following situations:

### Mouse

- The input mode is set to `BENTO_MODE_MOUSE`
- The mouse pointer is within the bounding box of the target element
- No other element is drawn on top of the target element ("between" the mouse and the target element)
- The element has its button type set to `BENTO_BUTTON_POINTER` or `BENTO_BUTTON_ALWAYS`

### Touch

- The input mode is set to `BENTO_MODE_TOUCH`
- The touchpoint is within the bounding box of the target element
- No other element is drawn on top of the target element ("between" the touchpoint and the target element)
- The element has its button type set to `BENTO_BUTTON_POINTER` or `BENTO_BUTTON_ALWAYS`

### Keyboard

- The input mode is set to `BENTO_MODE_KEYBOARD`
- The player has navigated to the button using directional input or Bento has decided to focus the element for another reason (such as destroying the previously hovered element)
- The element has its button type set to `BENTO_BUTTON_NAVIGATION` or `BENTO_BUTTON_ALWAYS`

### Gamepad

- The [input mode](Topic-Input-Modes) is set to `BENTO_MODE_GAMEPAD`
- The player has navigated to the button using directional input or Bento has decided to focus the element for another reason (such as destroying the previously hovered element)
- The element has its button type set to `BENTO_BUTTON_NAVIGATION` or `BENTO_BUTTON_ALWAYS`

&nbsp;

## Hold & Click

Bento's "hold" state is called "click" or "grab" in other UI frameworks. More technically, "hold" is a state that indicates an element has received, or continues to receive, an active primary input (clicking and holding a mouse button, holding down the spacebar, holding down the A button on a gamepad).

Before going further, it is critical to understand the difference between what Bento considers a "click". A click within Bento is a deliberate activation of an element (typically a button) by the player. When using a mouse, it is usually the case that a button is only considered "clicked" when the mouse button is released. However, on a touchscreen and when using a gamepad or keyboard, it’s usually the case that a button is "clicked" on a press rather than a release. As such, Bento will treat user interface elements as clicked in different ways depending on the input mode.

!> It is very important to detect players clicking buttons by calling explicitly `BentoPrimaryGetClick()`. If you check against any other function then your user interface is liable to work incorrectly.

Bento stores hold state per element. An element can have one of four values for its hold state. The table below explains when each state occurs.

|Name      |Held on the previous frame|Held on the current frame|Getter function            |
|----------|--------------------------|-------------------------|---------------------------|
|"no hold" |❌                        |❌                      |`not BentoPrimaryGetHold()`|
|"press"   |❌                        |✅                      |`BentoPrimaryGetPress()`   |
|"hold"    |✅                        |✅                      |`BentoPrimaryGetHold()`    |
|"release" |✅                        |❌                      |`BentoPrimaryGetRelease()` |

Only one element may be held per layer. If a layer is backgrounded, the held element (if there is one) will be transitioned first to the "release" state and then to the "no hold" state. When that layer is foregrounded, the element will remain not held.

An element can only be pressed (for the hold state to start) if that element is hovered and the primary input itself has been pressed whilst the element is hovered. This means that, in the example of mouse input, pressing the mouse button whilst hovering over some empty space and then moving the mouse to hover an element will not cause the element to be pressed or held. The element must first be hovered then the mouse button must be pressed for an element to be held. The same applies to navigation [input modes](Topic-Input-Modes) as well.

Bento also allows you to detect long presses and long clicks etc.  This is especially useful on mobile devices where a long press is often interpreted as an alternate interaction for e.g. a tooltip. Elements by default will not be able to receive long input and will instead perceive long input as standard (short) input. You must call `BentoSetLongPress()` for elements that you would like to configure to receive long input. You may adjust the length of time that the primary input must be active for to count as a "long" input by adjusting the `BENTO_LONG_CLICK_TIME` config macro.

You should use the following function variants to check for long holds:

|Getter function            |Long variant                   |
|---------------------------|-------------------------------|
|`not BentoPrimaryGetHold()`|`not BentoPrimaryGetLongHold()`|
|`BentoPrimaryGetPress()`   |`BentoPrimaryGetLongPress()`   |
|`BentoPrimaryGetHold()`    |`BentoPrimaryGetLongHold()`    |
|`BentoPrimaryGetClick()`   |`BentoPrimaryGetLongClick()`   |
|`BentoPrimaryGetRelease()` |`BentoPrimaryGetLongRelease()` |