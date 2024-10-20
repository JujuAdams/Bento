// Feather disable all

/// @param [instance=id]

function GuiAnimGet(_instance = id)
{
    return instance_exists(_instance)? _instance.__animating : false;
}