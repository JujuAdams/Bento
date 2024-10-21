// Feather disable all

/// Sets the position and size of an instance to encapsulate of its children (including "outside"
/// children). The `padding` parameter adds space around the edges of the children equally in all
/// directions.
/// 
/// @param [padding=0]
/// @param [instance=id]

function GuiSetSizeAroundChildren(_padding = 0, _instance = id)
{
    GuiSetSizeAroundChildrenExt(_padding, _padding, _padding, _padding, _instance);
}