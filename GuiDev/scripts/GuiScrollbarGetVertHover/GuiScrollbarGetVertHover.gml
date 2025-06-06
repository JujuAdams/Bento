// Feather disable all

/// @param [element=self]

function GuiScrollbarGetVertHover(_element = self)
{
    return (GuiExists(_element) && (__scrollbarVert != undefined))? _element.GUI_VARS.__scrollbarVert.hoverScrollbar : false;
}