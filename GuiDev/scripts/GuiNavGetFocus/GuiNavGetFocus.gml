// Feather disable all

/// @param [instance=self]

function GuiNavGetFocus(_instance = self)
{
    return GUI_EXISTS(_instance)? _instance.GUI_VARS.__focused : false;
}