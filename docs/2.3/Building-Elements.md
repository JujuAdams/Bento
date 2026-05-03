# Building Elements

&nbsp;

Bento does not come with a toybox filled with ready-to-use widgets. Instead, Bento provides functions and events/callbacks that you can use to build your own custom user interface elements. That having been said, I have built out a selection of examples for the most common types of element to get you started. You can find these examples [on the Bento repo](https://github.com/JujuAdams/Bento/). Example elements can be found in the project in the `Bento Examples` folder.

?> Bento has no preconceived notion of what your elements are going to look like or do. You can make your elements look however you want and do (almost) anything you want. Bento only concerns itself with giving you deep foundations for your UI.

Elements may be object instances or structs. This page will deal first with object instances as they are the most familiar concept for most GameMaker developers. Structs operate similarly to object instances within Bento and will be dealt with afterwards.

&nbsp;

## ngl i didnt read it fam

- Object instances must inherit from `oBentoAncestor`
- `event_inherited()` must be called at the top of a Create event before anything else
- Do not deactivate Bento object instances. Call `BentoActivateInstances()` if you're using instance deactivation
- An object instance's other events will execute as normal ...
- ... but you should put Bento-related code in the following events:
  - Create event works as normal. You should set up your Bento element here if necessary
  - User Event 0 is called when updating an element (this is Bento's "Step" event)
  - User Event 1 is called when drawing an element (this is Bento's "Draw" event)
  - User Event 2 is called when after drawing an element and after drawing all of its children (this is Bento's version of a "Draw End" event)
  - User Event 3 is called when an element is hovered and will draw over other sibling elements
  - User Event 4 is called when dragging an element in the drag-and-drop system and will draw over all other elements
  - User Event 5 is called when changing the position or size of an element
- ***Exactly what you draw is up to you.*** Check against the various getter functions (such as `BentoCursorGetHover()`) to alter the appearance of elements depending on their state
- There is no guarantee that Bento events will be executed on any given step. Bento [minimises how much of your code it executes](Principles) to keep performance as tight as possible
- Do not use any of the native Draw events. Bento has its own Draw loop
- Do not use any of the native GameMaker keyboard, mouse, or gamepad input events
- You may occasionally want to use the native Step event but try to put Bento-specific logic in User Event 0 to help Bento optimise

&nbsp;

## Object Instances

Bento instances are intended to be open and easy to use. They obey similar rules to standard GameMaker objects but have a number of unique behaviour available to them.

!> Do not deactivate Bento object instances. Call `BentoActivateInstances()` if you're using instance deactivation.

### Inheritance

Firstly, Bento object instances must all be children of `oBentoAncestor` and the Create event for your Bento element must include `event_inherited()` as the first line. `oBentoAncestor` sets up the element and without an object inheriting from this parent, Bento will not work. Please note that all Bento instances are presumed to be [persistent]() and the `persistent` variable is set to `true` by `oBentoAncestor` manually in code. [Bento is its own world](Principles) and the presumption is that the user interface should not be affeccted by room changes.

### Variables

Bento elements will be created and initialized with a few read-only variables. One in particular is a struct called `__bentoVars` and within it are all the variables necessary to track the state of the element within Bento. Putting these variables inside the struct keeps your elements organised and simple when inspecting them in the debugger. The other read-only variables are as follows:

| Variable                                                   | Purpose                                                                                        |
|------------------------------------------------------------|------------------------------------------------------------------------------------------------|
| `bentoLeft`<br>`bentoTop`<br>`bentoRight`<br>`bentoBottom` | Axis-aligned bounding box for the element, ignoring any rotation                               |
| `bentoX`<br>`bentoY`                                       | Origin of the element. This defaults to wherever the origin is for the object's `sprite_index` |
| `bentoWidth`<br>`bentoHeight`                              | Size of the element's bounding box in each axis                                                |

Object instances will automatically adjust their native GameMaker variables (`x` `y` `image_xscale` etc.) to respect the values that Bento has set (you can see this in the default User Event 5 code in `oBentoAncestor`). If in doubt, you can always use these Bento-specific variables to draw graphics.

You may override the default origin behaviour (using the origin of `sprite_index` for the object) by calling `BentoSetOrigin()`. If you change an object's `sprite_index` to something with a different origin and would like to keep the origin up to date, please call `BentoSetOriginAuto()` immediately afterwards.

### Events

Bento uses a system of custom user events to structure when and how code is executed. Bento elements that are object instances will still obey all the normal rules of object instances, however. The Create event is often essential to set up your Bento element but using Bento's custom event structure you'll find that most other native GameMaker events aren't helpful. At any rate, These user events are:

| User Event | Bento Name     | Native Equivalent | Behaviour                                                                                                                                      | Usage                                                                                       |
|------------|----------------|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| `0`        | "Step"         | Step              | Called if necessary but often omitted                                                                                                          | Bento logic, such as checks against `BentoPrimaryGetClick()`, should go in here             |
| `1`        | "Draw"         | Draw              | Before applying GPU scissoring for the element (if applicable) and before drawing children                                                     | The "main" draw event for elements                                                          |
| `2`        | "Draw After"   | Draw End (ish)    | After drawing children and after resetting GPU scissoring                                                                                      | Useful for drawing graphics over child elements such as an attractive border                |
| `3`        | "Draw Hover"   | *n/a*             | Only called when an element is hovered. Called after all sibling children but before resetting GPU scissoring for a layout ancestor            | Drawing highlights on and around hovered elements, especially when in directional mode      |
| `4`        | "Draw Dragged" | *n/a*             | Only called when an element is being dragged in the drag-and-drop system and at the very end of the draw loop after all other elements         | Drawing a drag-and-drop item above all other elements                                       |
| `5`        | "Reposition"   | *n/a*             | Called whenever an element's layout position or layout size changes. This event will also be called when a drag-and-drop item is being dragged | Resetting properties (such as `image_xscale`) that rely on the size and shape of an element |

!> There is no guarantee that Bento events will be executed on any given step. Bento [minimises how much of your code it executes](Principles) to keep performance as tight as possible.

Because Bento has its own draw loop, you should not use any of the Draw events whatsoever. You also do not need to use any of the native input events because Bento has its own features. Whether or not you choose to use the Step event varies depending on the situation but typically you'll want to avoid using it. Instead, put as much logic as possible in User Event 0 to allow Bento to optimise what code is being called and when.

&nbsp;

## Structs

Struct-based elements offer advantages over object instance-based elements. Full object instances are "heavier" than structs and have higher processing overhead. Given that user interfaces usually involve a lot of moving pieces, reducing the processing overhead is to our advantage. Object instances also appear in the debugger and can clutter up various tables. Many people prefer the development experience of using structs and constructors too. At any rate, if you'd like to use structs instead of object instances then some slight differences must be noted.

Much like Bento instances must inherit from `oBentoAncestor`, Bento structs must be made by a constructor function that inherits from `BentoConstrAncestor`. This constructor takes one parameter which is the parent. You should use the following constructor format for your own Bento-compatible constructors:

```gml
function CustomElement(_parent = other) : BentoConstrAncestor(_parent) constructor
{
    ...
}
```

Structs don't have the same native GameMaker variables that object instances do. This means to draw graphics you will need to use Bento's own layout position variables, such as `bentoLeft` and `bentoY` etc.

Structs also don't have the concept of "User Events". Instead, a struct-based Bento element contains a number of equivalent method callbacks that take the place of User Events for structs. Please see the following table for more information:

| User Event | Equivalent Method  |
|------------|--------------------|
| `0`        | `eventStep`        |
| `1`        | `eventDraw`        |
| `2`        | `eventDrawAfter`   |
| `3`        | `eventDrawHover`   |
| `4`        | `eventDrawDragged` |
| `5`        | `eventReposition`  |

When constructing a Bento-compatible struct, you should set up callback methods by setting these variables to functions that you want to execute. The behaviour and timing of their execution is the same as the equivalent User Events.
