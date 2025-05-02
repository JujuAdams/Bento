/// @desc Draw

// This event is executed downstream of `GuiSystemDraw()`. Most GUI instances will draw themselves.
// However, if a sibling UI instance with a higher priority is set to `GUI_BEHAVIOR_BLOCK_SIBLINGS`
// then lower priority UI instances will not draw. Please see the `GUI Behaviors` note for more
// information.