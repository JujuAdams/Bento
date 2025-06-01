// Feather disable all

/// @param [element=self]

function GuiClipGetEnabled(_element = self)
{
    return GuiExists(_element)? _element.GUI_VARS.__scissorEnabled : false;
}