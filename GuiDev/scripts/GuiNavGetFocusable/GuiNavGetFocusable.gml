// Feather disable all

/// @param [instance=id]

function GuiNavGetFocusable(_instance = id)
{
    return instance_exists(_instance)? _instance.GUI_STRUCT.__focusable : false;
}