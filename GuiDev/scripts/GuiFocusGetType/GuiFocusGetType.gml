// Feather disable all

/// @param [element=self]

function GuiFocusGetType(_element = self)
{
    return __GuiExists(_element)? _element.GUI_VARS.__focusType : false;
}