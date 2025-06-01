// Feather disable all

/// @param [element=self]

function GuiScrollbarGetHoriOver(_element = self)
{
    return (GuiExists(_element) && (__scrollbarHori == undefined))? _element.GUI_VARS.__scrollbarHori.overScrollbar : false;
}