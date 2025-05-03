// Feather disable all

/// @param [element=self]

function GuiNavToggleFocus(_element = self)
{
    GuiNavSetFocus(not GuiNavGetFocus(_element), _element);
}