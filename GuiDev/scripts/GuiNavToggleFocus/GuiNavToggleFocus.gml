// Feather disable all

/// @param [instance=self]

function GuiNavToggleFocus(_instance = self)
{
    GuiNavSetFocus(not GuiNavGetFocus(_instance), _instance);
}