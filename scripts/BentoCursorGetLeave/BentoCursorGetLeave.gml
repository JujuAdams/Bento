// Feather disable all

/// Returns whether the cursor has left (newly un-hovered) the element.
/// 
/// @param [element=self]

function BentoCursorGetLeave(_element = self)
{
    if (not BentoExists(_element)) return false;
    return (_element.BENTO_VARS.__hoverState == __BENTO_STATE_END);
}