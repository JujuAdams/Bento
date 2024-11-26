// Feather disable all

/// @param [instance=id]

function GuiNavGetFocus(_instance = id)
{
    return instance_exists(_instance)? _instance.__focused : false;
}