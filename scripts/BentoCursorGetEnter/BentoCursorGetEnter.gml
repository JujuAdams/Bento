// Feather disable all

/// Returns whether the cursor has entered (newly hovered) the element.
/// 
/// @param [element=self]

function BentoCursorGetEnter(_element = self)
{
    if (not BentoExists(_element)) return false;
    return (_element.BENTO_VARS.__hoverState == __BENTO_START);
}