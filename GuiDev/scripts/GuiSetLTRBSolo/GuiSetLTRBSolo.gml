// Feather disable all

/// Sets the position and size of an instance based on an LTRB bounding box. This function, unlike
/// `GuiSetLTRB()`, will not move the target instance's children.
/// 
/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [instance=id[

function GuiSetLTRBSolo(_left, _top, _right, _bottom, _instance = id)
{
    with(_instance)
    {
        GuiSetPositionSolo(0.5*(_left + _right), 0.5*(_top + _bottom), _instance);
        
        width  = _right - _left;
        height = _bottom - _top;
    }
}