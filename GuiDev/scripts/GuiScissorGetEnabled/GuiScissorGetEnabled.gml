// Feather disable all

/// @param [instance=self]

function GuiScissorGetEnabled(_instance = self)
{
    return GUI_EXISTS(_instance)? _instance.GUI_VARS.__scissorEnabled : false;
}