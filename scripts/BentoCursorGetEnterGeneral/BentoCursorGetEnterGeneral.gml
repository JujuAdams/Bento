// Feather disable all

/// Returns whether the cursor has entered (newly hovered) the element. This function will return
/// `true` regardless of whether the element was newly hovered due to player input or due to some
/// fallback logic inside Bento. Please see `BentoCursorGetEnterByPlayer()` for a comparison
/// of behaviours.
/// 
/// @param [element=self]

function BentoCursorGetEnterGeneral(_element = self)
{
    if (not BentoExists(_element)) return false;
    return (_element.BENTO_VARS.__hoverState == __BENTO_STATE_START);
}