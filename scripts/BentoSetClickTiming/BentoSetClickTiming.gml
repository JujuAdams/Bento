// Feather disable all

/// Set the preferred click timing for a button. `timingType` must be `BENTO_CLICK_ON_PRESS`,
/// `BENTO_CLICK_ON_RELEASE`, or `undefined`. If you set the click timing to `undefined` then
/// Bento will choose the click timing based on what input mode is being used:
/// 
/// BENTO_MODE_MOUSE    = click on release
/// BENTO_MODE_KEYBOARD = click on press
/// BENTO_MODE_GAMEPAD  = click on press
/// BENTO_MODE_TOUCH    = click on press
/// 
/// N.B. Bento will override the preferred click timing if it's necessary to keep the user
///      interface functional. If a button is inside a scroller, if the button can be dragged
///      within the drag & drop system, or if the button is set to support long presses then click
///      on release will be forced.
/// 
/// @param timingType
/// @param [element=self]

function BentoSetClickTiming(_timingType, _element = self)
{
    with(__BentoGetVars(_element))
    {
        __clickTiming = _timingType;
    }
}