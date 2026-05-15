// Feather disable all


/// Sets whether an element should stay hovered whilst its layer is backgrounded. You may specify
/// one of four modes:
/// 
/// `BENTO_MAINTAIN_NEVER`
///     The element will be unhovered when its layer is backgrounded.
/// 
/// `BENTO_MAINTAIN_POINTER`
///     The element will only remain hovered when its layer is using mouse or touch input.
/// 
/// `BENTO_MAINTAIN_NAVIGATION`
///     This is the default value. The element will only remain hovered when its layer is using
///     keyboard or gamepad input.
/// 
/// `BENTO_MAINTAIN_ALWAYS`
///     The element will remain hovered when its layer is backgrounded regardless of input mode.
/// 
/// Whether an element should remain hovered is decided at the moment the layer is backgrounded. If
/// the layer state (or the environment state) changes after the layer is backgrounded then the
/// hover state of the element will not change. For example, if a button is clicked and opens a new
/// layer whilst the player is using a gamepad and then the player changes to mouse input then the
/// button will remain hovered.
/// 
/// Regardless of whatever mode is set, if you are using a navigation input mode then when an
/// element's layer is foregrounded then the previously hovered element will be re-hovered.
/// 
/// @param mode
/// @param [element=self]

function BentoSetMaintainBackgroundHover(_mode, _element = self)
{
    if (BentoExists(_element))
    {
        _element.BENTO_VARS.__backgroundHover = _mode;
    }
}