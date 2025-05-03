// Feather disable all

/// @param element

function GuiNavGetBranched(_element)
{
    if (not __GuiExists(_element)) return false;
    
    return _element.GUI_VARS.__branched;
}