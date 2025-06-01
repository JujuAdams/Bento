// Feather disable all

/// @param [element=self]

function GuiScrollbarGetVertOver(_element = self)
{
    return (GuiExists(_element) && (__scrollbarVert != undefined))? _element.GUI_VARS.__scrollbarVert.overScrollbar : false;
}