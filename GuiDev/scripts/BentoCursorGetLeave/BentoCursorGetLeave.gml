// Feather disable all

/// Returns whether the cursor has left (newly un-hovered) the instance.
/// 
/// @param [element=self]

function BentoCursorGetLeave(_element = self)
{
    if (not BentoExists(_element)) return false;
    return (_element.GUI_VARS.__hoverState == __GUI_END);
}