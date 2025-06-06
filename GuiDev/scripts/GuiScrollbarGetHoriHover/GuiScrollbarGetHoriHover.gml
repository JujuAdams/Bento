// Feather disable all

/// @param [element=self]

function GuiScrollbarGetHoriHover(_element = self)
{
    return (GuiExists(_element) && (__scrollbarHori == undefined))? _element.GUI_VARS.__scrollbarHori.hoverScrollbar : false;
}