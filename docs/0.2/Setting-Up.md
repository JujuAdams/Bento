# Setting Up

?> Unlike most of my other libraries, Bento has a number of essential steps to take before it can be used. Please follow these instructions closely.

&nbsp;

## Importing Bento

GameMaker allows you to import assets directly into your project via the "Local Package" system. From the [Releases](https://github.com/JujuAdams/Bento/releases) tab for this repo, download the .yymp file for the latest version. In the GM IDE, load up your project and click on "Tools" on the main window toolbar. Select "Import Local Package" from the drop-down menu then import all scripts, objects, and sprites from the Bento package.

## Coordinate Spaces

Before doing anything with Bento, you must decide what coordinate space you want your user interface to work in. Your choice of coordinate system will determine exactly how to set up Bento. You have three options:

1. **GUI-space**. Your coordinate system will be based on the GUI layer (used for the Draw GUI events). This is probably the most common way of implementing user interfaces in GameMaker regardless of style, but is particularly beneficial for high resolution games.

2. **View-space**. Your coordinate system will be based on room coordinates, adjusted so that the origin (x = 0, y = 0) is located at the top-left corner of a view. This is less common and is typically used for pixel art games (though by no means exclusively).

3. **Room-space**. This is similar to view-space but without the "view" bit. Most games will be using cameras and views so room-space UIs aren't especially helpful; however, room-space UIs are applicable for simple games or for testing Bento without needing to set up other infrastructure.

Next, choose a persistent instance that will exist in all rooms in your game. If you chose to use a GUI-space coordinate system, create a Draw GUI event and call `BentoSystemDraw()` in it; otherwise, create a standard Draw event and call `BentoSystemDraw()` in it. `BentoSystemDraw()` is responsible for rendering every element that you create with Bento and must be run every frame for the player to be able to see anything.

## User Input

Bento supports multiple forms of user input: mouse, keyboard, gamepad, and touchscreen. Bento however does not concern itself with collecting user input and instead you will need to tell Bento what inputs the user is making. You can pass user input data into Bento by using the `BentoInput*()` functions. For example, for basic mouse input you'd execute this code:

```gml
/// GUI-space
GuiInputPointer(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), device_mouse_check_button(0, mb_left));

/// View-space or room-space
GuiInputPointer(device_mouse_x(0), device_mouse_y(0), device_mouse_check_button(0, mb_left));
```

?> If you're looking for a convenient tool to wrangle different input devices, I recommend [Input}(https://github.com/offalynne/Input).