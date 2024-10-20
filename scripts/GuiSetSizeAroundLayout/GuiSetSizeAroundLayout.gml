// Feather disable all

/// @param layout
/// @param padding
/// @param [instance=id]

function GuiSetSizeAroundLayout(_layout, _padding, _instance = id)
{
    GuiSetSizeAroundLayoutExt(_layout, _padding, _padding, _padding, _padding, _instance);
}