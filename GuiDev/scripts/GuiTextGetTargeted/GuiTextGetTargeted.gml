// Feather disable all

/// @param [element=self]

function GuiTextGetTargeted(_element = self)
{
    return GuiExists(_element)? (_element.GUI_VARS.__layer.__environment.__textElement == _element) : false;
}