# Technology - Step Code

?> This page covers some of the technology behind Bento. Because Bento is a framework that is intended to be used as the basis for later custom UI solutions, it's important that it's clear how things work and why. I encourage you to read Bento's source code as you read through this page.

&nbsp;

## Step Code

When an element executes its Step code, either User Event 0 will be executed (for instance elements) or the `funcStep` method will be executed (struct elements).

Elements only execute Step code if they need to, though many element behaviours will automatically cause this to happen. An element will execute Step code in the following situations:

- The element's button type (as set by `BentoSetButton()`) is active for the current input mode (e.g. is set to `BENTO_BUTTON_POINTER` and the player is using a mouse)
- `GUI_ALWAYS_EXECUTE_STEP` has been set to `true`
- `BentoGetForceStep()` has been called for the element
- The element has been focused with `GuiFocusOpen()`
- The element has a scissor text (clipping region) set up with `BentoScissorSetEnabled()`

However, you can always prevent Step code (and other code) from being executed if an element is disabled using `BentoSetDisabled()`. This overrides any other logic.

&nbsp;

## Step Order

Bento's step order is a recursive algorithm as follows:

1. If the element is disabled, abort
2. If the element is eligible, execute Step code
3. Iterate over children of the element in order and process them

 As an example, let's consider a Bento layer that is constructed like so:

```
Bento layer
╰─ Root element
   ╰─ Inventory window
      ├─ Scrollbox
      │  ├─ Apple item
      │  ├─ Banana item
      │  │  ╰─ Peel button
      │  ╰─ Cherry item
      ╰─ Close button
```

Presuming that all elements are eligible to execute Step code, the Step code order that will be produced is:

1. Root element
2. Inventory window
3. Apple item
4. Banana item
5. Peel button
6. Cherry item
7. Close button

?> The [Draw order](Tech-Draw-and-Draw-After) is built in broadly the same way. When detecting which element (if any) the pointer is hovering over, Bento iterates over the Step order but in reverse.

This is called a depth-first tree traversal. Bento's step order is cached and is executed by iterating over an array of method calls to avoid re-executing the same logic every single frame. The cached Step order is created by `__GuiEnsureStepOrder()`. This function is rather plain but does contain an interesting wrinkle in that the Step order starts at the most recently [focused element](Tech-Focus) where suitable.