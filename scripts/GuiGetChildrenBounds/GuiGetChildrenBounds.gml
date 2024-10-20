// Feather disable all

/// @param [padding=0]
/// @param [instance=id]

function GuiGetChildrenBounds(_padding = 0, _instance = id)
{
    return GuiGetChildrenBoundsExt(_padding, _padding, _padding, _padding, _instance);
}