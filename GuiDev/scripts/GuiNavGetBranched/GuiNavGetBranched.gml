// Feather disable all

/// @param [element=self]

function GuiNavGetBranched(_element = self)
{
    return __GuiExists(_element)? _element.GUI_VARS.__branched : false;
}