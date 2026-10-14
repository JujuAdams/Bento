# Drawing Elements

&nbsp;

Bento makes no presumptions about what you're going to draw. I have built examples of common user interface elements which are [available in the Bento repo](https://github.com/JujuAdams/Bento) but Bento leaves possibilities wide open when it comes to drawing graphics.

The main constraint on graphics in Bento is based around object instance User Events ([or callbacks for structs](Topic-Building-Elements)). Because Bento has its own draw loop, you should not use any of the Draw events whatsoever. Instead, you must use the User Events explained below. The User Event you will be using most of the time to draw elements is User Event 1. For more information regarding events, please see the [Building Elements](Topic-Building-Elements) page.

!> There is no guarantee that Bento events will be executed on any given step. Bento [minimises how much of your code it executes](Topic-Principles) to keep performance as tight as possible.

The following table shows the User Events that may be executed for an element when `BentoSystemDraw()` is called. These events are numbered in roughly the order that they are executed.

| User Event | Native Equivalent | | Behaviour                                                                                                                                     | Usage                                                                                       |
|------------|-------------------|-|-----------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| `1`        | Draw              | | Before applying GPU scissoring for the element (if applicable) and before children                                                            | The "main" draw event for elements                                                          |
| `2`        | Draw End (ish)    | | After children and after resetting GPU scissoring                                                                                             | Useful for drawing graphics over child elements such as an attractive border                |
| `3`        | *n/a*             | | Only called when an element is hovered. Called after all sibling children but before resetting GPU scissoring for a layout ancestor           | Drawing highlights on and around hovered elements, especially when in navigation mode       |
| `4`        | *n/a*             | | Only called when an element is being dragged in the drag-and-drop system. After all other elements, executed at the very end of the draw loop | Drawing a drag-and-drop item underneath the cursor                                          |

When you call `BentoSystemDraw()`, Bento will decide which elements need to be drawn and in what order. Of particular note is that only visible elements will be drawn. Any element that falls outside of an active scissor region is flagged to be ignored and its User Events are liable to not be executed at all.

Generally speaking, you will be using User Event 1 for the majority of your draw calls. If you'd like to draw graphics over children then you'll want to use User Event 2. User Event 3 comes up when drawing highlights on and around elements that are currently hovered. User Event 4 is drawn over everything else and is only executed when an element is being dragged in the drag-and-drop system.

Elements will be drawn in terms of their layout heirarchy. This means parents are drawn before their children. The order that children are drawn relative to their siblings (elements that have the same parent) is defined by the "depth" of an element. Don't be confused, this is not the same "depth" that you will be familiar with in native GameMaker. Bento's depth values, adjusted by `BentoSetDepth()` etc., relative only to the order than an element is drawn relative to other elements with the same parent.

If you're using object instances for your Bento elements then the native GameMaker variables will be set up to draw graphics as you would normally expect. However, when using structs for Bento elements then you will need to rely on Bento's read-only native position variables e.g. `bentoLeft` and `bentoY`. Please see the [Building Elements](Topic-Building-Elements) page for more information on what read-only variables are available.