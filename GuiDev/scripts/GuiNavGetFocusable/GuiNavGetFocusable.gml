// Feather disable all

/// @param [element=self]

function GuiNavGetFocusable(_element = self)
{
    return __GuiExists(_element)? _element.GUI_VARS.__focusable : false;
}