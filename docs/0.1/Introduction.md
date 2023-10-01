# Introduction

&nbsp;

Bento is a user interface framework. It is intended to be used for player-facing UI rather than, say, debug menus. This library doesn't seek to solve every single user interface problem, but it should cover the majority of basic games.

This page will introduce you to the various concepts in Bento. There's a lot to talk about and organising it is, honestly, something I haven't totally figured out yet. You're welcome to swing by [the Discord](https://discord.gg/8krYCqr) to ask targeted questions at your leisure.

&nbsp;

## BentoScript

One of the core principles of Bento is making it easy to iterate quickly on your UI layouts. Bento offers a GML API to build interfaces but the library works best when you use the custom BentoScript language instead. BentoScript is similar to GML, it just has a couple special features to make it more convenient to use.

Using a custom scripting language has a couple major advantages. The really big one is that Bento supports live coding. If you're not happy with where a button is on your main menu, you can change the script that builds the main menu and it'll update immediately in-game. This is very helpful! BentoScript is so powerful that you could quite easily build an entire game inside of it. You can read more about BentoScript [here](BentoScript).

?> Despite live programming being a major feature, I didn't write most of it! BentoScript is a modified version of the incomparable [Catspeak](https://github.com/katsaii/catspeak-lang) by [Katsaii](https://www.katsaii.com/). I highly recommend investigating Catspeak if you need any sort of flexible scripting solution for your game.

&nbsp;

## Structure

The basic unit of logic in Bento is the "UI element". A Bento UI element is implemented as a struct internally. UI elements are always attached to another UI element, creating a parent-child relationship. By attaching child UI to parent UI repeatedly, we can build a tree of UI elements. This is similar to the "document object model" if you're familiar with HTML and web tech in general.

As a practical example, consider a small pause menu that appears in the centre of the screen. The pause menu background occupies a small portion of the screen rather than filling it. The buttons on the pause menu are children of the pause menu background, and the menu background is the parent.

At the top of the UI tree is a layer. Every UI element will, at the top of its chain of parents, eventually reach a layer. Layers can have their order exchanged, of course, but their real power comes in how upper layers can be used to block input reaching lower layers. By blocking input, a layer can act as a [modal](https://semantic-ui.com/modules/modal.html). An example of a modal is a confirm dialogue box for deleting a save file. You can read more about layers over on the [layers](Layers) page.

&nbsp;

## Templates & Customisation

It's not possible to cover every style of user interface with a single library. Instead, Bento is trying to be easily extensible and customisable instead of being outright comprehensive. In the sidebar you'll find a list of common UI elements that Bento ships with. These should cover the majority of the interface you'll need to build for even relatively complex games.

By using a combination of GML's [constructor inheritance](https://manual.yoyogames.com/GameMaker_Language/GML_Overview/Structs.htm) and Bento's own callback system, it's possible to build some really pretty menus simply by reskinning the template UI elements. Customisation is discussed in more depth [on this page](Customisation).

&nbsp;

## Gamepad Support & Cross-Platform

Bento is written using 100% native GML so it will (should) work on all target platforms. However, not all platforms have the same input hardware. A desktop PC will typically use a mouse for UI input, or perhaps a keyboard or gamepad. Mobile phones have a touch screen. Consoles will use gamepad input exclusively (apart from Switch if you're feeling adventurous!). This library abstracts hardware input so you don't need to worry about managing the nitty gritty details.

Input is funneled into Bento using device-agnostic functions. Bento uses an internal pointer that can act as a free roaming stand-in for mouse or touch input. When using a gamepad, Bento disables free roaming and instead uses a raycast to detect which UI element to lock on to.

Button input from hardware, such as a left mouse click or the A button on a gamepad, is again funnelled into Bento with a specific function. If you create a user interface that works with a mouse, even without polishing it, it'll probably work with a gamepad too. Bento also differentiates between "target" button clicks (which are actions directed at a specific UI element) and "cast" button clicks (which are actions broadcast more generally). For example, right-clicking on an item to open a context menu is a "target" click and pressing Escape to close a pause menu is a "cast" click.