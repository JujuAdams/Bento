// Feather disable all

/// @param [instance=self]

function GuiNavGetFocusable(_instance = self)
{
    return GUI_EXISTS(_instance)? _instance.GUI_VARS.__focusable : false;
}