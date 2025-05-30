// Feather disable all

/// @param [element=self]

function GuiGetButton(_element = self)
{
    return GuiExists(_element)? _element.GUI_VARS.__buttonType : GUI_BUTTON_NEVER;
}