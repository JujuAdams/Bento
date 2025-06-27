// Feather disable all

/// @param [element=self]

function BentoScrollbarGetHoriHover(_element = self)
{
    return (BentoExists(_element) && (__scrollbarHori == undefined))? _element.BENTO_VARS.__scrollbarHori.hoverScrollbar : false;
}