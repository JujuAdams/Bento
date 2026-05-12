// Feather disable all

/// Returns whether the cursor has entered (newly hovered) the element by direct input from the
/// player. This function can be used to play audio or trigger a particle effect when an element
/// is hovered.
/// 
/// This function, unlike `BentoCursorGetEnter()`, will return `false` if an element has been
/// hovered without specific player input. This can happen in many situations:
/// - Destroying the currently hovered element when using navigation input
/// - Destroying a UI page and creating a new UI page
/// - Swapping from pointer input to navigation input
/// - Entering into a focusable container e.g. a scrollbox
/// 
/// @param [element=self]

function BentoCursorGetEnterByPlayer(_element = self)
{
    if (not BentoExists(_element)) return false;
    return _element.BENTO_VARS.__byPlayer;
}