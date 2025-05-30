// Feather disable all

/// @param [element=self]

function GuiFocusGetEnclose(_element = self)
{
    return GuiExists(_element)? _element.GUI_VARS.__focusEncloseType : false;
}