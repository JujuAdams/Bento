# Principles

Building Bento has taken over 6 years. In this span of time, I've come to realise that the decisions I've made look separate but are actually interlinked, like beads knotted onto the threads of Bento's core principles. I've developed these principles as a way to guide Bento's construction.

&nbsp;

## Bento is its own world

I have come to realise that a user interface is a game engine onto itself. There is so much complexity and so many rules that don't map cleanly onto standard gameplay programming. User interfaces are largely about restricting user input to a few distinct states that change deliberately rather than a large set of continuous states that the player can smoothly move between. Bento must recognise this and it must stand apart from the rest of the game engine wherever possible.

When we start seeing a user interface as an engine within an engine then it comes apparent that Bento needs to have its own "Step" loop and its own "Draw" loop. This is reflected in the two functions `BentoSystemStep()` and `BentoSystemDraw()` which handle these two loops. Additionally, Bento must have its own [input management API](Input). Bento needs to have its own events and state tracking that avoids directly interacting with native GameMaker systems as far as is possible.

&nbsp;

## Cross-platform or bust

Cross-platform development is where a lot of money gets made in GameMaker. Bento must not get in the way of a developer releasing a game on other platforms. This means every feature must support every one of the [input modes](Input). If a feature is extremely useful but cannot be supported on every platform this then must be highlighted and, if possible, throw an error at runtime.

This principle does **not** apply to aspect ratio flips. There is no magic spell that converts a landscape interface to a portrait interface. That work has to be done manually. Bento's goal is to make that conversion as painless as possible via the use of algorithmic layouts and reusable element patterns but Bento cannot convert layouts automatically for the user.

&nbsp;

## Bento should think like a GameMaker dev

Ask a Discord with `n` GameMaker developers a question and you'll get `n(n+1) / 2` opinions. GameMaker's great strength is its adaptability. GameMaker great curse is its lack of structure. There are many community-endorsed "good practices" but the reality of working in GameMaker is that it's very easy to hack a solution together without being aware that an accepted solution already exists. As a result, Bento can't on much in the way of a shared understanding of the engine. Bento should therefore rely as much as possible on the lowest common denominator of knowledge without sacrificing features or performance if we can help it.

Here are some examples to illustrate the downstream impact of this principle:

### Leverage the event system and object editor

Whilst I think GameMaker's UX is subpar by and large, the object editor's basic functionality is clear because the underlying logic in GameMaker's runtime is clear: Events happen at predictable times and, when they do, the relevant code for that event is executed. If we, as GameMaker developers, want something to happen we put it in the associated event in the object editor. In reality, developers will rarely use anything more than the core events but the concept is easy to grasp and easy to generalise. Bento should hook into this way of thinking by using custom [User Events](User-Events) for key "events" that Bento triggers. This keeps code structured, it makes it easier to navigation, and it's familiar to every GameMaker developer. Sadly, GameMaker offers us a limited number of User Event slots but Bento doesn't need all that many so it ends up being fine.

?> I consider the "core events" to be Create, Step, the various Draw events, Clean Up (or Destroy). Bento's custom [User Events](User-Events) reflect this.

### Getters instead of callbacks

The event system is easy to understand but often clumsy. Instead of using any one of the many dedicated events, it is common practice to do a lot of gameplay logic in the Step event where order of execution is clearer and code is more easily reviewed. Games as a whole have an awful lot of state that needs to be tracked and Bento is not immune to the same problems. There would simply be too many events for a developer to learn if we created one for every state change in Bento. Even if that weren't true, we'd still hit the limit on the number of custom User Events that GameMaker affords us.

There is an alternative to an event and that is a "callback". A callback is a function (usually a method) that is called when a stage change occurs. Callbacks are typically defined in a Create event and, when something happens, that callback is executed for entities that need to know about it. In a sense, GameMaker's "events" are interchangeable with callbacks. So why shouldn't we make a whole bunch of callbacks instead of of a whole bunch of events?

Putting to one side the problem that having many callbacks is no easier to learn than having many events, callbacks are just not a common idea in GameMaker right now. They are an unfamiliar concept for most people. Remembering that **Bento should think like a GameMaker dev**, we must come to the conclusion that callbacks aren't something that should be relied upon for critical core use of Bento.

We do still need to have an interface for Bento users though so, instead of requiring an understanding of callbacks, Bento should have many state getter functions that the user can call. Along with this, Bento should allow the user to check against that state getter function every step. This is a comfortable design pattern for GameMaker users, it allows us to use the object editor to organise code organisation, and it is also easier to write documentation for.

&nbsp;

## Bento is not a collection of widgets

Many UI libraries, in GameMaker and beyond, fixate on providing out-of-the-box widgets that can be dropped into a codebase and "just work". I believe this to be a fantasy. The reality is that every application has their own specific needs, not least in how the application looks. This leaves the Widget Maker in a tough position. If you don't provide enough flexibility then a developer cannot get the look and behaviour they want; however, if you provide too much flexibility then it's overwhelming for new users and future updates to widgets will break existing implementations.

Figuring out the exact widget customisation surface to expose is, in my opinion, an impossible task. Bento should take a step back and instead provide the raw ingredients that allows users to build whatever appearance and behaviour they want. Examples should still be provided, people still need to know where to start, but explicit and official be-all and end-all solutions are not compatible with what Bento is.

This leads us to a corollary: Bento's documentation should "prefer recommendations rather than requirements" for use. I consider Bento (and libraries as a whole) as being a figurative contract being the library-maker and the library-user. Bento should provide reliable and predictable behaviour that users can build on top of. Part of this contract is for Bento's documentation to not go beyond recommending how to use the API. So long as Bento does what it says it is going to do, how the end-user makes use of that is then up to them. Insisting on particular solutions is unhelpful.

&nbsp;

## Clicking is a distinct action

Because Bento is a cross-platform library, it must accommodate different expectations when it comes to user input. On a desktop platform, it is expected that buttons activate when the user presses a button and then releases that button whilst the mouse is hovering over the top of it. When using a touchscreen, it is more often the case that a button is activated when the player taps the button, which is a press rather than a release. Finally, when using a gamepad or a keyboard, buttons are usually activated when highlighted by the cursor (usually a virtual cursor) and then the "accept" button is pressed, usually the `A` button or the `space` key.

These input mechanisms are subtly different. Bento must embrace them all. As a result, Bento introduces the concept of "click" as an entirely different state to press, hold, or release. A click lasts for only one step in the same way a press or a release lasts for only one step. However, when a click happens exactly depends on a multitude of factors. We've already discussed the different expectations depending on [input mode](Input) but clicks will also be triggered at different times depending on the context that the button is in. You can read more about clicks [here](Click).

&nbsp;

## Bento grows on trees

The "document object model", or DOM, is the model by which virtually every web page is organised. Bento is built around a similar concept where the entire user interface exists within a tree:

```
system
╰─ environment
   ├─ layer A
   │  ╰─ root element
   │     ├─ element
   │     │  ├─ element
   │     │  ╰─ element
   │     ╰─ ...
   ├─ layer B
   ╰─ ...
```

In Bento, there is only ever one "system". This is the global handler that coordinates all Bento state and code. The next level down hosts one or more environments. Environments can be thought of as containers that hold separate [user input](Input). If there are multiple players using one user interface each then you'll want to create a separate environment per player. For the vast majority of use cases (including multiplayer games where only one player can control the user interface at a time), you will only need to use one environment.

Layers exist inside environments. You can have any number of layers in an environment; however, only the layer drawn last and on top (which is typically the most recently created layer) can receive input. Any other layer is considered "backgrounded". Backgrounded layers will usually not execute any update code (that's [User Event 0](Building-Elements)) but will continue to draw themselves using the other user events. The intention for layers is that they operate as modals which block input to lower layers. In the above example, `layer A` is backgrounded and cannot be interacted with and `layer B` is in the foreground and will operate as normal.

Each layer has precisely one root element. Other than never having any sibling elements, the root element behaves like any other element. You may create further elements as children of the root element, and those elements may have children, and so on. It is in this repeating pattern of elements as children of other elements that the user interface tree takes shape.

&nbsp;

## Draw order emerges from the tree

Draw order is a critical part of any 2D rendering. GameMaker uses the [painter's algorithm](https://en.wikipedia.org/wiki/Painter%27s_algorithm) in conjunction with a `depth` value. Objects, tilemaps, and other graphics with a higher numerical depth are drawn earlier. Graphics with a lower numerical depth are drawn later. This means that graphics can be layered over each other in an explicit order to get the final output that you want.

User interfaces also need to have their draw order be clear and unambiguous so that the output is predictable and controllable. However, they are also very complex with lots of interdependent parts. User interfaces aren't like the game worlds that GameMaker is built to render best. Bento uses a nested document model where elements are children of other elements. Keeping track of relative depth values in a user interface to execute draw commands in the right order becomes unworkable with even a small amount of nesting and layering.

Instead, we can observe that a sensible draw order emerges traversing the document model [depth-first](https://en.wikipedia.org/wiki/Depth-first_search). This typically gives us the draw order that we want (technically this is a reverse depth-first traversal):

```
element 0
╰─ element 1
   ├─ element 2
   │  ├─ element 3
   │  ├─ element 4
   │  ╰─ element 5
   ╰─ element 6
```

In this tree, the element are drawn from top-to-bottom in the tree. If we consider that `element 2` might be a frame that contains three children that are buttons, we can imagine how the draw order here will render the buttons on top of the frame. `element 6` is then drawn over `element 2`.

However, we will sometimes find ourselves in situations where we want to adjust draw order to be different to what the tree would otherwise imply. Bento has its own depth system that can be used to adjust draw order between sibling elements that share a parent. In the above example, `element 3`, `element 4`, and `element 5` are siblings to each other (`element 2` and `element 6` are also siblings). By adjusting Bento native depths we can reorder these elements:

```
element 0
╰─ element 1
   ├─ element 2
   │  ╰─ element 5, depth =  1
   │  ╰─ element 4, depth =  0
   │  ├─ element 3, depth = -1
   ╰─ element 6
```

Bento's depths will only affect the order that siblings are drawn; Bento depths cannot be used to change the global draw order.

&nbsp;

## Virtual cursor

When we think of "hovering" a button we naturally think about a mouse pointer being over the top of that button. Alternatively, we could consider a hovered button in a console game as being the button that is currently selected and is highlighted. Bento combines these two expectations into a single concept called a "virtual cursor".

When using pointer [input modes](Input) (mouse or touch), hovering a button works like you'd expect. The cursor follows the mouse exactly and the top-most button underneath the cursor is hovered. When using touch input, the cursor is only active when the screen is touched; otherwise, touch input and mouse input work the same.

When using directional [input modes](Input) (keyboard or gamepad), the cursor position is determined to be the centre of the currently hovered button. When the player pushes the cursor in a direction (using the thumbstick or arrow keys etc.), the cursor will find the next element in that direction and will jump to it. That new element is then considered hovered.

?> There is one virtual cursor per layer. This is especially helpful for directional input. If you create a new layer and then destroy it, the underlying layer will remember which element was hovered.

Directional input modes want to hover a button. Unless there are no available or valid buttons, directional input will always hover something. If a button is destroyed, the virtual cursor will move to the nearest available button and hover it. If a new layer is created, the virtual cursor for that layer will hover an available button. Directional input will also intelligently scroll containers so that the player can navigate the entire interface using only a gamepad or keyboard.