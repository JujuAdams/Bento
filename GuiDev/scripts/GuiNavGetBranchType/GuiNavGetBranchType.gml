// Feather disable all

/// @param [element=self]

function GuiNavGetBranchType(_element = self)
{
    return __GuiExists(_element)? _element.GUI_VARS.__branchType : false;
}