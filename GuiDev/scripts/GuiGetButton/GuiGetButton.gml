// Feather disable all

/// @param [element=self]

function GuiGetButton(_element = self)
{
    return __GuiExists(_element)? _element.GUI_VARS.__buttonType : GUI_BUTTON_NEVER;
}