// Feather disable all

/// Sets the position and size of an instance based on an LTRB bounding box. If that instance has
/// any children (inside or outside) then the children will follow the parent.
/// 
/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [instance=id]

function GuiSetLTRB(_left, _top, _right, _bottom, _instance = id)
{
    with(_instance)
    {
        GuiSetSize(1 + _right - _left, 1 + _bottom - _top);
        GuiSetPosition(_left, _top, _instance, fa_left, fa_top);
    }
}