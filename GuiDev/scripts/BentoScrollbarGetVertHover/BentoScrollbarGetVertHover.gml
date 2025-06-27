// Feather disable all

/// @param [element=self]

function BentoScrollbarGetVertHover(_element = self)
{
    return (BentoExists(_element) && (__scrollbarVert != undefined))? _element.GUI_VARS.__scrollbarVert.hoverScrollbar : false;
}