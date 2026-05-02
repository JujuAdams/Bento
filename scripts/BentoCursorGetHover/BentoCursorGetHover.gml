// Feather disable all

/// Returns whether the cursor is hovering the given element.
/// 
/// @param [element=self]

function BentoCursorGetHover(_element = self)
{
    if (not BentoExists(_element)) return false;
    return ((_element.BENTO_VARS.__hoverState & __BENTO_STATE_START) > 0);
}