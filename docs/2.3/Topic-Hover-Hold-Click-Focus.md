# Hover vs. Hold vs. Click vs. Focus

&nbsp;

Every user interface uses different terminology for element state. Bento has three main states that a button can be in: hovered, held, and focused. You may be familiar with these terms from other frameworks where their meaning and usage is different to Bento. Ahead of time, I will apologise for any confusion.

&nbsp;

## Hover

Bento's "hover" state is called "mouse over" or "highlight" in other UI frameworks. More technically, "hover" is a state that indicates an element will be the recipient of the primary input when activated (clicking a mouse button, pressing the spacebar, press the A button on a gamepad).

The hover state applies to pointer (mouse, touch) [input modes](Topic-Input-Modes) as well as navigation (keyboard, gamepad) input modes. When using a pointer input mode, an element will be hovered if it is the top-most element underneath the pointer.

When using a navigation input mode, Bento will track which element is hovered for you [using an internal cursor](Topic-Principles?id=virtual-cursor) without there being an explicit pointer coordinate. Bento will ensure that an element will always be hovered if there is a hoverable element available. This means that destroying the currently hovered element will cause the internal cursor to avoid another element, typically the next nearest element to where the cursor was previously. When using a navigation input mode, it is often helpful to be able to visualise where the internal cursor is. You may use the `BentoCursorGetBox()` function to return the bounding box of the element that the internal cursor is currently hovering.

Bento stores hover state per element. An element can be multiple states at once depending on the situation. The table below explains when each state occurs.

|Name      |Hovered on the previous frame|Hovered on the current frame|Getter function                                                           |
|----------|-----------------------------|----------------------------|--------------------------------------------------------------------------|
|"no hover"|❌                          |❌                          |`not BentoCursorGetHover()`                                               |
|"enter"   |❌                          |✅                          |`BentoCursorGetEnterByNavigation()`<br>or `BentoCursorGetEnterByGeneral()`|
|"hover"   |*any*                        |✅                          |`BentoCursorGetHover()`                                                   |
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

- The input mode is set to `BENTO_MODE_GAMEPAD`
- The player has navigated to the button using directional input or Bento has decided to focus the element for another reason (such as destroying the previously hovered element)
- The element has its button type set to `BENTO_BUTTON_NAVIGATION` or `BENTO_BUTTON_ALWAYS`

&nbsp;

## Hold & Click

Bento's "hold" state is called "click" or "grab" in other UI frameworks. More technically, "hold" is a state that indicates an element has received, or continues to receive, an active primary input (clicking and holding a mouse button, holding down the spacebar, holding down the A button on a gamepad).

Before going further, it is critical to understand the difference between what Bento considers a "click". A click within Bento is a deliberate activation of an element (typically a button) by the player. When using a mouse, it is usually the case that a button is only considered "clicked" when the mouse button is released. However, on a touchscreen and when using a gamepad or keyboard, it’s usually the case that a button is "clicked" on a press rather than a release. As such, Bento will treat user interface elements as clicked in different ways depending on the input mode.

!> It is very important to detect players clicking buttons by calling explicitly `BentoPrimaryGetClick()`. If you check against any other function then your user interface is liable to work incorrectly.

Bento stores hold state per element. An element can be multiple states at once depending on the situation. The table below explains when each state occurs.

|Name      |Held on the previous frame|Held on the current frame|Getter function            |
|----------|--------------------------|-------------------------|---------------------------|
|"no hold" |❌                        |❌                      |`not BentoPrimaryGetHold()`|
|"press"   |❌                        |✅                      |`BentoPrimaryGetPress()`   |
|"hold"    |*any*                     |✅                      |`BentoPrimaryGetHold()`    |
|"click"   |*n/a*                     |*n/a*                    |`BentoPrimaryGetClick()`   |
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

&nbsp;

## Focus

Bento's "focus" state does not have a clear analogue in other UI frameworks, or at least I don't know of an analogue (please get in touch if you do). Bento's "focus" is a way for you to separate regions of your user interface and to allow input in one region and to prevent input in others.

There are many examples of what Bento calls "focus" in user interface design. The most familiar example is a context menu. I'm presuming you're on a desktop OS, but try right-clicking on this web page and then navigate that menu using the arrow keys on your keyboard. You'll notice that navigation is limited to what is inside that context menu. In Bento's terminology this means that the context menu is "focused". Only content within the context menu can be navigated to. However, if you return to using your mouse, you'll find that you can still click on the web page behind the context menu without impairment.

?> This example presumes the context menu is transient. For static lists that need to be separated from the rest of the interface, please see the "Enclosure" section below.

Another example of focus is a slider on a settings menu. Let's consider volume adjustment for a game. When using a mouse (or touchscreen), you can easily click and drag the handle on the slider to adjust the volume. However, it is often the case that when using keyboard or gamepad input you must first hover the slider then activate it (select it by pressing the spacebar or the A button on a gamepad) before you can adjust the volume by pressing left or right. In this situation, we can say that the slider itself is focused. Despite the slider not having any child elements, it is still a focusable element in the user interface.

Generally speaking, focus limits only apply to navigation [input modes](Topic-Input-Modes) (keyboard and gamepad). When using mouse or touch input, the expectation is usually that the player can interact with anything that's visible. This is not universally true and there are many reasons to restrict what can be interacted but these are uncommon.

There are two general rules:

1. If an element has hoverable descendents (children, or children of children etc.) then focusing the element will only allow its descendents to be hovered.

2. If an element has **no** hoverable descendents then focusing the element will only allow the element itself to be hovered.

We can modify the above rules to handle various different situations where we might want pointer input to behave differently to navigation input. The table below explains what focus types are available and how they behave:

|Focus type                            |Behaviour                                                                                              |
|--------------------------------------|-------------------------------------------------------------------------------------------------------|
|`BENTO_FOCUS_POINTER_IGNORE`          |Pointer ignores focus limits. Any hoverable element can be interacted with whilst an element is focused|
|`BENTO_FOCUS_POINTER_CANCEL_ON_CLICK` |Pressing outside of the focused part of the free will cancel the focus                                 |
|`BENTO_FOCUS_POINTER_DESTROY_ON_CLICK`|Pressing off of the focused part of the tree will destroy the focused element                          |
|`BENTO_FOCUS_POINTER_CANCEL_ALWAYS`   |Focus is cancelled automatically if the input mode is set to `BENTO_MODE_POINTER`                      |
|`BENTO_FOCUS_POINTER_CONSTRAIN`       |Pointer is constrained inside the focused part of the tree. The user will not be able to hover, hold, or click elements outside of the focused part of the tree.<br>**N.B.** You should be careful with this focus type as it is possible to softlock your game!|

You can start focus on any element by calling `BentoFocusOpen()`. This function requires that you specify a focus type from the table above. You can return whether an element is focused or not by calling `BentoGetFocused()`. You can unfocus an element by calling `BentoFocusClose()`. As an example, you may wish to unfocus a listbox if the user pressed the B button on their gamepad. Sometimes it's helpful to toggle focus and that can be done with `BentoFocusToggle()`. There are a handful of other focus-related functions and I leave exploring them up to you.

### Enclosure

"Enclosure" is a special feature in Bento that allows elements to be visible but unhoverable (and therefore uninteractable). This is very commonly used for [listboxes](https://en.wikipedia.org/wiki/List_box). When using a navigation input mode, it would be inconvenient to have to scroll all the way through a list of elements to navigate from the top of an interface to the bottom. Instead, we "enclose" the elements inside the listbox and make them unhoverable. To access the contents of the listbox, the player first has to navigate to hover the listbox, then focus the listbox (by clicking it), and only then is the player able to scroll through the list of enclosed elements. By closing the focus on the listbox is the player then able to return to navigating the rest of the interface.

Enclosure of child elements can be set up by calling `BentoFocusSetEnclose()`. This function takes an enclosure type. If you set the enclosure type to something other than `BENTO_ENCLOSE_NEVER` then Bento will control whether child elements are hoverable according to the rules below:

|Enclosure type            |Behaviour                                                                                                                                                                                              |
|--------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`BENTO_ENCLOSE_NEVER`     |Child elements are never enclosed and can always be interacted with. This is the default value                                                                                                         |
|`BENTO_ENCLOSE_ALWAYS`    |Child elements are always enclosed and cannot be interacted with unless the parent is focused                                                                                                          |
|`BENTO_ENCLOSE_NAVIGATION`|Child elements are enclosed in navigation input modes only. Pointer input modes modes will be able to select elements freely. **This is the most commonly used enclosure type**                        |
|`BENTO_ENCLOSE_POINTER`   |Child elements are enclosed in pointer input modes modes only. Navigation input modes modes will be able to select elements freely. This is probably never useful and is provided only for completeness|