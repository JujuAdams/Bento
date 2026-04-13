/// @desc Step

// This event is executed downstream of `BentoSystemStep()`. To improve performance, only elements
// that need to execute this user event will do so. An element will execute this event in the
// following circumstances:
// 
// - The element's button type matches the input mode (see `BentoSetButton()` and `BentoSetMode()`).
// - Forced step executed has been enabled for the element by `BentoSetPushStep()`
// - The element has been focused by `BentoFocusOpen()`
// - The element has a clipping region set up by `BentoClipSetEnabled()`
// - `BENTO_ALWAYS_EXECUTE_STEP` is set to `true`