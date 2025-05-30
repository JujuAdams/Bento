// Feather disable all

/// @param [element=self]

function GuiGetIsContainer(_element = self)
{
    return GuiExists(_element)? (_element.GUI_VARS.__containerTarget != undefined) : false;
}