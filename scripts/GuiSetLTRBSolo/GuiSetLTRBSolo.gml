// Feather disable all

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