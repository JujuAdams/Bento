# Setting Up

!> Unlike most of my other libraries, Bento has a number of essential steps to take before it can be used. Please follow these instructions closely.

### tl;dr

This page is pretty long and, ideally, you should read it all ... having said that, here's the executive summary if you're in a rush:

1. Import the .yymps from [the repo](https://github.com/JujuAdams/Bento/releases)
2. Create a new object called `oBentoAncestorMirror`. It should inherit from `oBentoAncestor`. All custom Bento objects that you create should inherit from `oBentoAncestorMirror`
3. Decide what [coordinate space](Setting-Up?id=coordinate-spaces) you want to work in. Usually this will be GUI-space
4. Create (or choose an existing) a persistent instance that will be in every room. Add `BentoSystemDraw()` to an event: **Draw GUI** for GUI-space, **Draw** for other coordinate spaces
5. In the same persistant instance, hook up user input in the Step event by calling `BentoInput*()` functions. Add `BentoSystemStep()` to the end of the Step event
6. Create a test instance with `BentoCreate()` and run the game.

&nbsp;

## Importing Bento

GameMaker allows you to import assets directly into your project via the "Local Package" system. From the [Releases](https://github.com/JujuAdams/Bento/releases) tab for this repo, download the .yymp file for the latest version. In the GM IDE, load up your project and click on "Tools" on the main window toolbar. Select "Import Local Package" from the drop-down menu then import all scripts, objects, and sprites from the Bento package.

## Object Parents

You'll want to make it as easy as possible to update Bento in the future. Perhaps there's a version with a new feature that you want, or there's a bug fix in a newer version that you need. When using [instance elements](Tech-UI-Elements) you will need to inherit from an object called `oBentoAncestor` that is packaged with the library. Unfortunately, GameMaker behaves in an irritating way when importing packages: if a parent object is overwritten by an incoming package then all children of that object will lose their parent.

Let's give a practical example. Let's say I import Bento and make a new object called `oCoolButton` that inherits from `oBentoAncestor`. In a couple months, I spot a Bento update that I want. I download the package, import it into GameMaker, and overwrite all existing code. `oCoolButton` will now no longer inherit from `oBentoAncestor` and the game will crash when I try to interact with `oCoolButton`.

For one or two objects, re-establishing object inheritance is no big deal. However, as your project grows you are liable to need dozens of specific UI objects, all inheriting from `oBentoAncestor`. Whilst there's no true "fix" for GameMaker breaking inheritance when importing a package, we can instead work around the problem by minimizing the impact:

1. Create a new object called `oBentoAncestorMirror`
2. Set `oBentoAncestorMirror` to inherit from the library object `oBentoAncestor`
3. All custom Bento objects that you create should inherit from `oBentoAncestorMirror`

Whilst this setup is circuitious, it will make life a lot less painful down the road.

?> [Struct elements](Tech-UI-Elements) don't need any special consideration and can inherit directly from `BentoConstrAncestor`.

## Coordinate Spaces

Before doing anything with Bento, you must decide what coordinate space you want your user interface to work in. Your choice of coordinate system will determine exactly how to set up Bento. You have three options:

1. **GUI-space**. Your coordinate system will be based on the GUI layer (used for the Draw GUI events). This is probably the most common way of implementing user interfaces in GameMaker regardless of style, but is particularly beneficial for high resolution games.

2. **View-space**. Your coordinate system will be based on room coordinates, adjusted so that the origin (x = 0, y = 0) is located at the top-left corner of a view. This is less common and is typically used for pixel art games (though by no means exclusively).

3. **Room-space**. This is similar to view-space but without the "view" bit. Most games will be using cameras and views so room-space UIs aren't especially helpful; however, room-space UIs are applicable for simple games or for testing Bento without needing to set up other infrastructure.

Next, choose a persistent instance that will exist in all rooms in your game. If you chose to use a GUI-space coordinate system, create a **Draw GUI** event and call `BentoSystemDraw()` in it; otherwise, create a standard **Draw** event and call `BentoSystemDraw()` in it. `BentoSystemDraw()` is responsible for rendering every element that you create with Bento and must be run every frame for the player to be able to see anything.

## User Input

Bento supports multiple forms of user input: mouse, keyboard, gamepad, and touchscreen. Bento however does not concern itself with collecting user input and instead you will need to tell Bento what inputs the user is making. You can pass user input data into Bento by using the `BentoInput*()` functions. For example, for basic mouse input you'd execute this code:

```gml
/// GUI-space
GuiInputPointer(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), device_mouse_check_button(0, mb_left));

/// View-space or room-space
GuiInputPointer(device_mouse_x(0), device_mouse_y(0), device_mouse_check_button(0, mb_left));
```

?> If you're looking for a convenient tool to wrangle different input devices, I recommend [Input}(https://github.com/offalynne/Input).