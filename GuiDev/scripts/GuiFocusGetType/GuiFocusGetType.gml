// Feather disable all

/// @param [element=self]

function GuiFocusGetType(_element = self)
{
    return GuiExists(_element)? _element.GUI_VARS.__focusType : false;
}