// Feather disable all

/// Sets the position and size of an instance based on an LTRB bounding box. This function, unlike
/// `GuiSetLTRB()`, will not move the target instance's children.
/// 
/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [instance=id]

function GuiSetLTRBSolo(_left, _top, _right, _bottom, _instance = id)
{
    GuiSetSize(1 + _right - _left, 1 + _bottom - _top, _instance);
    GuiSetPositionSolo(_left, _top, _instance, fa_left, fa_top);
}