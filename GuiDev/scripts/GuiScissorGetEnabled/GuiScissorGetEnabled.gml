// Feather disable all

/// @param [instance=id]

function GuiScissorGetEnabled(_instance = id)
{
    return instance_exists(_instance)? _instance.__gui.__scissorEnabled : false;
}