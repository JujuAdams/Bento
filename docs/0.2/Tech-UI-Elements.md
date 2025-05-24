# Technology - UI Elements

?> This page covers some of the technology behind Bento. Because Bento is a framework that is intended to be used as the basis for later custom UI solutions, it's important that it's clear how things work and why. I encourage you to read Bento's source code as you read through this page.

&nbsp;

Bento centres its operation around the "user interface element". You'll see this abbreviated as "UI element" or "element" throughout the documentation for Bento. A user interface element is either an instance or struct that has been set up for use with Bento. If the element is an instance then that instance's object must inherit from the `oBentoAncestor` object. If the element is a struct then that struct's constructor must inherit from `BentoConstrAncestor`.

Most parts of an interactive UI would constitute an "element" using Bento's terminology. Buttons, checkboxes, sliders, scrollboxes and so on are examples of elements. Elements can also be non-interactive: text labels, graphics, and frames/containers would also all be elements. Bento offers flexibility beyond very basic components: a button with text written on it could be implemented as a button element that contains a text element, or you could create a special "text button" element that handles the button and the text at the same time.

An "element" is therefore a very general concept and much of your time using Bento will be spent thinking about the position, appearance, and functionality of UI elements. They are the building blocks for your user interface. Bento's core library ships with several examples of basic UI elements but any serious use will inevitably require writing custom element types that perform tasks unique to your game. As such, elements have a number of properties that change how Bento interfaces with them. These are explained in detail on other pages, but briefly they are:

- Button type
- Enabled / disabled
- Layout dimensions and behaviour
- Bento parent (used for layout, ownership etc.)
- Navigation
- Visibility
- Scroll
- Scissor test (clipping region)
- Focus
- Step code forced execution
- Draw After forced execution
- Matrix transform

This page will discuss the basic mechanics of text elements within Bento's source code. Understanding the operation of elements is a prerequisite for an understanding of further features.

## Instance Elements

As previously mentioned, if the element is an instance then that instance's object must inherit from the `oBentoAncestor` object, but let's look at what `oBentoAncestor` is actually doing. Our first stop is the [Create event](https://github.com/JujuAdams/Bento/blob/master/objects/oBentoAncestor/Create_0.gml). In this event we can see code that needs to be executed by all instance-based elements (struct elements have similar that we'll look at later).

At the very top of the Create event, we see that all instance elements are set as [persistent](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/Instance_Variables/persistent.htm). This is a necessary step to ensure that as we move between rooms elements aren't lost. You can of course manually destroy elements when you move between rooms by calling `BentoDestroy()` but Bento requires that you explicitly do so.

In the Create event we also see several read-only variables. These are `bentoLeft`, `bentoWidth` etc. and are used to store position information for the instance. Whenever Bento determines that the layout needs to be recalculated, these variables will be re-set. Regardless, the default position values are initialized based on the sprite used for the instance.

Next, a special variable called `BENTO_VARS` is created by instantiating a constructor called `__BentoClassVariables()`. This struct will be used to store all the internal variables that the element needs to function. `BENTO_VARS` is actually a macro whose value you are welcome to change by editing the `__BentoConfig` script. The default value for `BENTO_VARS` is `__bentoVars`. We use a separate struct to store Bento variables for the sake of a cleaner debugging experience - Bento needs instances to have a *lot* of extra variables attached to them and having those listed out would clutter up the debug view.

Finally, the instance is automatically set as a child to the currently scoped parent. This value is an internal variable within the library's system and is set via `BentoCreateObject()` or `BentoCreateFromJSON()`. All elements must have a parent and this line of code ensures this happens.

Looking at the event list we see four User Events that are used as callbacks by the central Bento system:

- `User Event 0 - Step`
- `User Event 1 - Draw`
- `User Event 2 - Draw After`
- `User Event 3 - Reposition`

So what's going on here? Bento uses a custom Step and Draw loop. Elements (instances and structs) will only execute Step behaviour and Draw behaviour when requested by Bento downstream of a call to `BentoSystemStep()` and `BentoSystemDraw()`. When Bento decides that an instance element needs to execute its Step code then it'll execute User Event 0 for that instance, and so on. These user events are effectively callbacks.

Whilst separating out element logic into User Events seems like a lot of work, it is an important affordance for performance. The less code is running the faster your game will run and so Bento wants to have tight control over what is being executed so that it can run optimally. However, this does mean that GameMaker's native Draw events aren't applicable for Bento elements. You can still use them if you want but they're unlikely to be helpful.

?> You should avoid using the standard GameMaker Draw events as they are broadly incompatible with Bento. Similarly, the standard Step event is only useful in specific situations and should only be used if you need code that is guaranteed to be executed every frame.

## Struct Elements

Whilst most people will be comfortable with using object instances as Bento elements, there are times when a struct is preferable. Perhaps you wish to use structs exclusively; this too is fine. Struct elements work in a very similar way to instance elements and, for Bento, all of the logic is the same anyway because structs and instances are largely interchangeable in GameMaker.

`BentoConstrAncestor()` should be inherited by all custom Bento-compliant constructors. An example custom element constructor might look like this:

```gml
/// @param parent

function CustomElement(_parent) : BentoConstrAncestor(_parent) constructor
{

}
```

Struct elements have four callbacks that correspond to the User Events that instance elements rely (see above). These are respectively:

- `funcStep`
- `funcDraw`
- `funcDrawAfter`
- `funcReposition`

As you may have guessed, these callbacks are executed when necessary by `BentoSystemStep()` and `BentoSystemDraw()` much like the User Events for instance elements. Struct element callbacks are executed in exactly the same places and for exactly the same reasons as instance element User Events. Indeed, Bento tends not to differentiate between instance elements and struct elements internally (for example, instance elements have their own set of `func*` callbacks that redirect to their User Events).

However, there is one place that Bento does differentiate between instance elements and struct elements. Struct elements can only be partially destroyed by `BentoDestroy()` owing to GameMaker's own implementation of structs. In the abstract general case, it's not possible to destroy a struct anywhere in GameMaker so long as a (strong) reference to that struct remains. This means that, unlike instances, we cannot ever manually remove a struct from memory; we must instead wait for the garbage collector to remove it for us.

How GameMaker treats structs has a knock-on effect on Bento. When you call `BentoDestroy()` on a struct element, that struct element will be removed from its parent and any children of the destroyed struct element will also be destroyed (which will then destroy _their_ children and so on). Instance elements are destroyed here using GameMaker's native `instance_destroy()`. This invalidates any references to the instance element and accessing the instance directly will result in a standard GameMaker "instance does not exist" error. However, structs cannot be destroyed whilst references to them exist and so you can end up in a situation where you have called `BentoDestroy()` but you can still access the struct. This is potentially dangerous. Bento offers a `BentoExists()` function to resolve this ambiguity.

!> When using struct elements you should take special care to use `BentoExists()` to check if the struct has been destroyed by Bento.