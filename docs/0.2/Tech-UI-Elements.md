# Technology

&nbsp;

?> This page covers some of the technology behind Bento. Because Bento is a framework that is intended to be used as the basis for later custom UI solutions, it's important that it's clear how things work and why. I encourage you to read Bento's source code as you read through this page.

&nbsp;

## UI Elements

Bento centres its operation around the "user interface element". You'll see this abbreviated as "UI element" or "element" throughout the documentation for Bento. A user interface element is either an instance or struct that has been set up for use with Bento. If the element is an instance, then that instance's object must inherit from the `oBentoAncestor` object. If the element is a struct, then that struct's constructor must inherit from `BentoConstrAncestor`.

Elements have a number of properties that change how Bento interfaces with them. These are explained in detail on pages, but briefly:

- Button type
- Enabled / disabled
- Layout dimensions and behaviour
- Bento parent (used for layout, ownership etc.)
- Navigation
- Visibility
- Scroll
- Clipping (scissor test)
- Focus
- Step and/or Draw End forced execution
- Matrix transform

&nbsp;

## Instance Elements

Let's look at what `oBentoAncestor` is actually doing. In the [Create event](https://github.com/JujuAdams/Bento/blob/master/objects/oBentoAncestor/Create_0.gml) we can see code that needs to be executed by all instance-based elements (struct elements have similar that we'll look at later).

Firstly, we see that all instance elements are set as [persistent](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/Instance_Variables/persistent.htm). This is a necessary step to ensure that as we move between rooms, elements aren't lost. You can of course destroy elements when you move between rooms by calling `BentoDestroy()` but Bento requires that you explicitly do so.

In the Create event we also see several read-only variables. These are `bentoLeft`, `bentoWidth` etc. and are used to store position information for the instance. Whenever Bento determines that the layout needs to be recalculated, these variables will be re-set. Regardless, the default position values are initialized based on the sprite used for the instance.

Next, a special variable called `BENTO_VARS` is created by instantiating a constructor called `__BentoClassVariables()`. This struct will be used to store all the internal variables that the element needs to function. `BENTO_VARS` is actually a macro whose value you are welcome to change by editing the `__BentoConfig` script. The default value for `BENTO_VARS` is `__bentoVars`. We use a separate struct to store Bento variables for the sake of a cleaner debugging experience - Bento needs instances to have a *lot* of extra variables attached to them and having those listed out would clutter up the debug view.

Finally, the instance is automatically set as a child to the currently scoped parent. This value is an internal variable within the library's system and is set via `BentoCreateObject()` or `BentoCreateFromJSON()`. All elements must have a parent and this line of code ensures this happens.

Looking at the event list we see four User Events:

- `User Event 0 - Step`
- `User Event 1 - Draw`
- `User Event 2 - Draw End`
- `User Event 3 - Reposition`

The normal GameMaker Step, Draw, and Draw End events have got comments in them directing you to use the User Event equivalent instead. Unless you have a good reason to do so, you should heed this advice. No such warning exists for the normal Step event, however.

So what's going on here? Bento uses a custom Step and Draw loop. Elements (instances and structs) will only execute Step behaviour and Draw behaviour when requested by Bento downstream of a call to `BentoSystemStep()` and `BentoSystemDraw()`. This is an important affordance for performance. The less code is running, the faster your game will run! However, this does mean that GameMaker's native Draw events aren't applicable for Bento elements. You can still use them if you want but they're unlikely to be helpful.

However, you'll note that the normal Step event does not carry the same warning as the Draw events. This is because the standard GameMaker Step event may still be useful for many types of elements and I wouldn't want Bento developers to think its use was banned. That having been said, you'll want to put most of your update logic in User Event 0.

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
- `funcDrawEnd`
- `funcReposition`

As you may have guessed, these callbacks are executed when necessary by `BentoSystemStep()` and `BentoSystemDraw()`.

## Step / UE0 / `funcStep`