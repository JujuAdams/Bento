# User Events

Bento uses a system of custom user events to structure when and how code is executed. Bento elements that are object instances will still obey all the normal rules of object instances, however. The Create event is often essential to set up your Bento element but using Bento's custom event structure you'll find that most other native GameMaker events aren't helpful. At any rate, These user events are:

| User Event | Bento Name     | Native Equivalent | Behaviour                                                                                                                                      | Usage                                                                                       |
|------------|----------------|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| `0`        | "Step"         | Step              | Called if necessary but often omitted                                                                                                          | Bento logic, such as checks against `BentoPrimaryGetClick()`, should go in here             |
| `1`        | "Draw"         | Draw              | Before applying GPU scissoring for the element (if applicable) and before drawing children                                                     | The "main" draw event for elements                                                          |
| `2`        | "Draw After"   | Draw End (ish)    | After drawing children and after resetting GPU scissoring                                                                                      | Useful for drawing graphics over child elements such as an attractive border                |
| `3`        | "Draw Hover"   | *n/a*             | Only called when an element is hovered. Called after all sibling children but before resetting GPU scissoring for a layout ancestor            | Drawing highlights on and around hovered elements, especially when in navigation mode       |
| `4`        | "Draw Dragged" | *n/a*             | Only called when an element is being dragged in the drag-and-drop system and at the very end of the draw loop after all other elements         | Drawing a drag-and-drop item above all other elements                                       |
| `5`        | "Reposition"   | *n/a*             | Called whenever an element's layout position or layout size changes. This event will also be called when a drag-and-drop item is being dragged | Resetting properties (such as `image_xscale`) that rely on the size and shape of an element |

!> There is no guarantee that Bento events will be executed on any given step. Bento [minimises how much of your code it executes](Topic-Principles) to keep performance as tight as possible.

Because Bento has its own draw loop, you should not use any of the Draw events whatsoever. You also do not need to use any of the native input events because Bento has its own features. Whether or not you choose to use the Step event varies depending on the situation but typically you'll want to avoid using it. Instead, put as much logic as possible in User Event 0 to allow Bento to optimise what code is being called and when.

&nbsp;

## User Event 0 "Step"

User Event 0 is analogous to GameMaker's native Step event. This user event is called downstream of `BentoSystemUpdate()` and should be used for interaction logic. This user event, however, is not always called and Bento will only call User Event 0 if necessary. The intention is to only execute User Event 0 for elements that can meaningfully interact with the user interface state. For example, buttons that are set to only function in navigation input modes don't need to check if they've been clicked if the current input mode is `BENTO_MODE_TOUCH`.

?> You can determine if an element will execute User Event 0 by calling `BentoGetExecutesStep()`.

The situations in which Bento will execute User Event 0 are as follows:

- No disabled element will execute User Event 0, regardless of the other factors below

- If an element is on a backgrounded layer then an element's User Event 0 is likely to not execute regardless of other factors. Usually eligible elements on backgrounded layers will execute User Event 0 for a step or two after a layer is backgrounded

- If `BENTO_ALWAYS_EXECUTE_STEP` has been set to `true` then all elements will execute User Event 0

- `BentoSetPushStep()` may be called to force User Event 0 execution for a particular element

- If an element is focused (via `BentoFocusOpen()`) then User Event 0 will be executed

- If an element has a clipping region defined (via `BentoClipSetEnabled()`) then User Event 0 will be executed

- If an element is clickable as a button then User Event 0 will be executed