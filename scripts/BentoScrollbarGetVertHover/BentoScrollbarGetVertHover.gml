// Feather disable all

/// Returns whether the vertical scrollbar is being hovered.
/// 
/// @param [element=self]

function BentoScrollbarGetVertHover(_element = self)
{
    return (BentoExists(_element) && (__scrollbarVert != undefined))? _element.BENTO_VARS.__scrollbarVert.hoverScrollbar : false;
}