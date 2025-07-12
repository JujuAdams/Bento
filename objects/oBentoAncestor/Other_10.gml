/// @desc Step

// This event is executed downstream of `BentoSystemStep()`. To improve performance, only elements
// that need to execute this user event will do so. An element will execute this event in the
// following circumstances:
// 
// - The element's button type (see `BentoSetButton()`) matches the input mode (see
//   `BentoSetMode()`).
// - Forced step executed has been enabled for the element by `BentoSetForceStep()`
// - The element has been focused by `BentoFocusOpen()`
// - The element has a clipping region set up by `BentoClipSetEnabled()`
// - `BENTO_ALWAYS_EXECUTE_STEP` is set to `true`