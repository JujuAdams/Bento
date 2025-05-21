# Technology - Draw & Draw End Code

?> This page covers some of the technology behind Bento. Because Bento is a framework that is intended to be used as the basis for later custom UI solutions, it's important that it's clear how things work and why. I encourage you to read Bento's source code as you read through this page.

&nbsp;

## Draw

Bento's draw order is a recursive algorithm as follows:

1. If the element is diabled, abort
2. Set a transformation matrix if necessary
3. If the element is visible, execute Draw code
4. Set a scissor test (clipping region) if necessary
5. Iterate over children of the element in order and try to draw them
6. Reset the clipping region
7. If the element is visible and has been set up to do so, execute Draw End code
8. Reset the transformation matrix

This is therefore a depth-first tree traversal and follows the [Painter's algorithm](https://en.wikipedia.org/wiki/Painter%27s_algorithm) like the rest of GameMaker. Bento's draw order is cached and is executed by iterating over an array of method calls to avoid re-executing the same logic every single frame - see [`__BentoEnsureDrawOrder()`].

When an element executes its Draw code, either User Event 1 will be executed (for instance elements) or the `funcDraw` method will be executed (struct elements).

All elements will execute Draw code unless they are set as invisible by calling `BentoSetVisible()` or have been disabled by `BentoSetDisable()`. An **invisible element** will not draw itself but will draw its children. A **disabled** element will draw neither itself nor its children.

!> Instance elements will not respect the native GameMaker `visible` property.

If an element has a visual transform set up (such as `BentoTransformSetAngle()`) then that transform will apply to the element and will also apply to its children. Visual transforms will not affect the collision mask for an element - they are purely for visual effect, such as panels sliding in.

### Draw End

When an element executes its Draw End code, either User Event 2 will be executed (for instance elements) or the `funcDrawEnd` method will be executed (struct elements).

An element does not normally execute any Draw End code for the sake of efficiency. If you would like an element to execute Draw End code, you should use `BentoSetDrawEnd()` to set this up.

Much like Draw code, Draw End code will not get executed if an element is invisible or has be disabled. Draw End code is also affected by any visual transform that you have set up for the element.