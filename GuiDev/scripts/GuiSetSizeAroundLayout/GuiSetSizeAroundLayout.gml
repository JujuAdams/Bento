// Feather disable all

/// Sets the position and size of an instance to encapsulate of all members of a layout. The
/// `padding` parameter adds space around the edges of the member instances equally in all
/// directions.
/// 
/// @param layout
/// @param padding
/// @param [instance=id]

function GuiSetSizeAroundLayout(_layout, _padding, _instance = id)
{
    GuiSetSizeAroundLayoutExt(_layout, _padding, _padding, _padding, _padding, _instance);
}