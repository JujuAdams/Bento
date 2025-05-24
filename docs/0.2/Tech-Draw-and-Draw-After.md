# Technology - Draw & Draw After Code

?> This page covers some of the technology behind Bento. Because Bento is a framework that is intended to be used as the basis for later custom UI solutions, it's important that it's clear how things work and why. I encourage you to read Bento's source code as you read through this page.

&nbsp;

When an element executes its Draw code, either User Event 1 will be executed (for instance elements) or the `funcDraw` method will be executed (struct elements).

All elements will execute Draw code unless they are set as invisible by calling `BentoSetVisible()` or have been disabled by `BentoSetDisable()`. An **invisible element** will not draw itself but will draw its children. A **disabled** element will draw neither itself nor its children.

!> Instance elements will not respect the native GameMaker `visible` property.

If an element has a visual transform set up (such as `BentoTransformSetAngle()`) then that transform will apply to the element and will also apply to its children. Visual transforms will not affect the collision mask for an element - they are purely for visual effect, such as panels sliding in.

## Draw After

When an element executes its Draw After code, either User Event 2 will be executed (for instance elements) or the `funcDrawAfter` method will be executed (struct elements). Draw After code is executed after an element draws its children but before the next element is drawn.

An element does not normally execute any Draw After code for the sake of efficiency. If you would like an element to execute Draw After code, you should use `BentoSetDrawAfter()` to set this up.

Much like Draw code, Draw After code will not get executed if an element is invisible or has be disabled. Draw After code is also affected by any visual transform that you have set up for the element.

## Draw Order

Bento's draw order is a recursive algorithm as follows:

1. If the element is disabled, abort
2. Set a transformation matrix if necessary
3. If the element is visible, execute Draw code
4. Set a scissor test (clipping region) if necessary
5. Iterate over children of the element in order and try to draw them
6. Reset the clipping region
7. If the element is visible and has been set up to do so, execute Draw After code
8. Reset the transformation matrix

As an example, let's consider a Bento layer that is constructed like so:

```
Bento layer
╰─ Root element
   ╰─ Inventory window
      ├─ Scrollbox
      │  ├─ Apple
      │  ├─ Banana
      │  │  ╰─ Peel button
      │  ╰─ Cherry
      ╰─ Close button
```

Let's say that the scrollbox is set up with a scissor test (clipping region). Let's further say that the inventory window has a Draw After event set up, perhaps to draw a decorative overlay. The Draw code order that will be produced is:

1. Root element **draw**
2. Inventory window **draw**
3. Scrollbox **draw**
4. Scrollbox **scissor region push**
5. Apple **draw**
6. Banana **draw**
7. Peel button **draw**
8. Cherry **draw**
9. Scrollbox **scissor region pop**
10. Close button **draw**
11. Inventory window **draw after**

This is therefore a depth-first tree traversal and follows the [Painter's algorithm](https://en.wikipedia.org/wiki/Painter%27s_algorithm) like the rest of GameMaker. Bento's draw order is cached and is executed by iterating over an array of method calls to avoid re-executing the same logic every single frame - see [`__BentoEnsureDrawOrder()`].