# Technology - Environments & Layers

?> This page covers some of the technology behind Bento. Because Bento is a framework that is intended to be used as the basis for later custom UI solutions, it's important that it's clear how things work and why. I encourage you to read Bento's source code as you read through this page.

&nbsp;

Bento largely organizes [UI elements](Tech-UI-Elements) into trees: any "parent" element can have other "child" elements attached to it. If the parent is moved, child elements are moved too. If the parent has a layout behaviour, child elements will be moved around accordingly to that behaviour. The ability to create parent-child relationships between elements is recursive which allows for trees of UI elements. This is common practice in many places, not least the HTML document object model.

However, user interfaces in games have special requirements that a simple tree of UI elements cannot solve; or at the very least, a simple tree of elements would be a suboptimal solution. This is where "environments" and "layers" come in. These two organisational tools allow you to separate the user interfaces into discrete parts that have particular helpful interaction rules.

Before getting into the weeds, it's helpful to have an overview of the structure of Bento above and beyond the element tree. Visually, Bento is structured like this:

```
Bento System
│
├─ Environment
│  ├─ Layer
│  │  ╰─ Root element
│  │     ├─ Element
│  │     │  ╰─ ...
│  │     ├─ Element
│  │     │  ╰─ ...
│  │     ╰─ ...
│  ├─ Layer
│  │  ╰─ Root element
│  │     ├─ ...
│  │     ╰─ ...
│  ╰─ ...
│
├─ Environment
│  ├─ Layer
│  │  ╰─ Root element
│  │     ├─ ...
│  │     ╰─ ...
│  ├─ Layer
│  │  ╰─ Root element
│  │     ├─ ...
│  │     ╰─ ...
│  ╰─ ...
│
╰─ ...
```

In plain English: Bento can contain multiple environments, environments can contain multiple layers, and each layers contains one root element. Each root element - one per layer - acts as a standard Bento UI element and acts as the root for the UI tree.

We'll discuss layers first as they are very helpful for handling common tricky UI tasks.

## Layers

When quitting a game from a pause menu, it's good practice to show a confirmation box to confirm whether the player truly intended to quit. When you disconnect a gamepad, you should pause the game and show a disconnection warning; indeed, this is a compliance requirement on consoles. When you choose to exit from a level editor, the UI should ask if you want to save your changes. These user interface windows all interrupt the flow of the game to ensure the player has an opportunity to respond to the information that is being presented to them.

These sorts windows are typically implemented as [modals](https://www.nngroup.com/articles/modal-nonmodal-dialog/). A modal will prevent interaction with other user interface elements. Deliberately so! You wouldn't want the player to be able to ignore something important. When the modal is closed, the player's control should return to whatever UI element was previous selected. For example, if the player has the "Quit Game" option selected using a gamepad but decides to cancel actually quitting the game then the selected button shouldn't change.

Bento achieves this by using "layers". Only the top-most layer will permit user interaction with lower layers retaining state. When the top-most layer is destroyed, control will be allowed on the new top-most layer. By pushing and popping layers, you can support many different scenarios. Let's say the player disconnects their gamepad whilst another modal is open - by pushing a new layer that shows the gamepad disconnection message, you can wait for the player to connect a new gamepad before returning player control to the prior modal.

For the avoidance of doubt, lower layers are still drawn and are drawn in ascending index order, starting with index 0. "Top-most" refers to the layer with the highest index in the array of layers for an environment i.e. if there are three layers in an environment then the layer at index 2 in the array is the top-most layer and is drawn last.

## Environments

Whilst Bento doesn't allow for multiple players to control different cursors at the same time on the exact same elements, Bento does allow for multiple players to control *different* elements. This is where environments come in; they are segregated "worlds" that can process different simultaneous user inputs. Let's say you'd like to make a splitscreen action game where players can open their own inventory on their half of the screen. Each player's interface would be a different environment.

Whilst the use of layers will come up in virtually every game sooner or later, environments are more niche tool. Most games probably won't need to make use of environments. Bento will automatically create a default environment when your game starts and you'll likely not need to fiddle more than that.

User input is scoped to one environment at a time. Bento will target the default environment unless otherwise instructed. You can target a different environment by pushing it onto the stack with `GuiEnvironmentTargetPush()` and return to the previous environment using `GuiEnvironmentTargetPop()`. **Make sure you pop any environment that you push otherwise you will encounter strange errors.**

Here's an example to handle user input from two players going to two environments:

```gml
//Collect P1 input
var _dx = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _dy = keyboard_check(ord("S")) - keyboard_check(ord("W"));
var _primary = keyboard_check(vk_space);

//Push user input to P1's environment
GuiEnvironmentTargetPush(environmentP1);
GuiInputDirectional(_dx, _dy, _primary);
GuiEnvironmentTargetPop();

//Collect P2 input
var _dx = keyboard_check(vk_right) - keyboard_check(vk_left);
var _dy = keyboard_check(vk_down) - keyboard_check(vk_up);
var _primary = keyboard_check(vk_enter);

//Push user input to P2's environment
GuiEnvironmentTargetPush(environmentP2);
GuiInputDirectional(_dx, _dy, _primary);
GuiEnvironmentTargetPop();
```