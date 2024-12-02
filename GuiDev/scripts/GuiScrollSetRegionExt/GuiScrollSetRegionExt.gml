// Feather disable all

/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [instance=id]

function GuiScrollSetRegionExt(_left, _top, _right, _bottom, _instance = id)
{
    with(_instance)
    {
        GuiScrollSetRegionAbsolute(bbox_left + _left, bbox_top + _top, bbox_right - _right, bbox_bottom - _bottom);
    }
}