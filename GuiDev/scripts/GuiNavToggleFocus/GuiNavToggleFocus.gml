// Feather disable all

/// @param [instance=id]

function GuiNavToggleFocus(_instance = id)
{
    GuiNavSetFocus(not GuiNavGetFocus(_instance), _instance)
}