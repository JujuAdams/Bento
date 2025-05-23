# Technology - Step Code

?> This page covers some of the technology behind Bento. Because Bento is a framework that is intended to be used as the basis for later custom UI solutions, it's important that it's clear how things work and why. I encourage you to read Bento's source code as you read through this page.

&nbsp;

Bento's step order is a recursive algorithm as follows:

1. If the element is disabled, abort
2. If the element is eligible, execute Step code
3. Iterate over children of the element in order and process them

This is therefore a depth-first tree traversal. Bento's step order is cached and is executed by iterating over an array of method calls to avoid re-executing the same logic every single frame - see [`__GuiEnsureStepOrder()`].

When an element executes its Step code, either User Event 0 will be executed (for instance elements) or the `funcStep` method will be executed (struct elements).

Elements only execute Step code if they need to, though many element behaviours will automatically cause this to happen. An element will execute Step code in the following situations:

- The element's button type (as set by `BentoSetButton()`) is active for the current input mode (e.g. is set to `BENTO_BUTTON_POINTER` and the player is using a mouse)
- `GUI_ALWAYS_EXECUTE_STEP` has been set to `true`
- `BentoGetForceStep()` has been called for the element
- The element has been focused with `GuiFocusOpen()`
- The element has a scissor text (clipping region) set up with `BentoScissorSetEnabled()`

However, you can always prevent Step code (and other code) from being executed if an element is disabled using `BentoSetDisabled()`. This overrides any other logic.