// Feather disable all

/// @param [element=self]

function GuiScissorGetEnabled(_element = self)
{
    return GUI_EXISTS(_element)? _element.GUI_VARS.__scissorEnabled : false;
}