/// @desc Step

// This event is executed downstream of `GuiSystemStep()`. Some instance configurations don't allow this
// event to be executed however - it'll only be executed if necessary. For example, if an instance
// is set to the `GUI_BEHAVIOR_COSMETIC` (which every instance is by default) then this event won't
// typically be executed. Please see the `GUI Behaviors` note for more information.