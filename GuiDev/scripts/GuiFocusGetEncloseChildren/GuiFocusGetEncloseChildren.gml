// Feather disable all

/// @param [element=self]

function GuiFocusGetEncloseChildren(_element = self)
{
    return __GuiExists(_element)? _element.GUI_VARS.__focusEncloseChildren : false;
}